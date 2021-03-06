# google test directories
GTEST_DIR := googletest/googletest
GMOCK_DIR := googletest/googlemock

# compiler
CXX ?= g++
# linker
LD ?= g++
# gcov
GCOV ?= gcov
# preprocessor flags
CPPFLAGS := -isystem $(GMOCK_DIR)/include -isystem $(GTEST_DIR)/include
# main compiler flags
CXXFLAGS := -std=c++11 -Wall -Wextra -pedantic -Wvla
# extra compiler flags
EXXFLAGS :=
# code coverage compile flags
CODE_COVERAGE_CXX_FLAGS := -coverage
# main linker flags
LDFLAGS := -pedantic -Wall
# extra linker flags
ELDFLAGS :=
# code coverage linker flags
CODE_COVERAGE_LD_FLAGS := -lgcov -coverage
# libraries
LIBS :=
# erase files command
RM := rm -f

# test executable
TEST_PROG := test.out
# test source files
TEST_SOURCES := $(wildcard *_test.c *_test.cpp)
# test object files
TEST_OBJS := $(patsubst %.c, %.o, $(filter %.c, $(TEST_SOURCES)))
TEST_OBJS += $(patsubst %.cpp, %.o, $(filter %.cpp, $(TEST_SOURCES)))
# test dependency files
TEST_DEPS = $(TEST_OBJS:%.o=%.d)

# executable
PROG := a.out
# source files
SOURCES := $(wildcard *.c *.cpp)
SOURCES := $(filter-out $(TEST_SOURCES), $(SOURCES))
# pre-compiled object files to link against
LINKEDOBJS := 
# object files for each source file
OBJS := $(patsubst %.c, %.o, $(filter %.c, $(SOURCES)))
OBJS += $(patsubst %.cpp, %.o, $(filter %.cpp, $(SOURCES)))
# all objects except for main.o
OBJS_MINUS_MAIN := $(filter-out main.o, $(OBJS))
# dependency files
DEPS = $(OBJS:%.o=%.d)


# code coverage files
CODE_COVERAGE_FILES := $(wildcard *.gcda *.gcno *.gcov gcovr-report*.html gcovr-report*.xml)
# code coverage exclude files flags
CODE_COVERAGE_EXCLUDE_FILES := $(foreach test_source, $(TEST_SOURCES),-e '$(test_source)')
CODE_COVERAGE_EXCLUDE_FILES += -e 'submodules/'
CODE_COVERAGE_EXCLUDE_FILES += -e '.test/'
CODE_COVERAGE_EXCLUDE_FILES += -e $(GTEST_DIR)/
CODE_COVERAGE_EXCLUDE_FILES += -e $(GMOCK_DIR)/

# scipts directory
SCRIPTS_DIR := scripts
# name of the install shell script
SETUP_SCRIPT := $(SCRIPTS_DIR)/setup.sh
# remove sample code script
REMOVE_SAMPLE_CODE_SCRIPT := $(SCRIPTS_DIR)/remove_sample_code.sh

# use quiet output
ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
	QUIET_CXX		= @echo '   ' CC $@;
	QUIET_LINK		= @echo '   ' LD $@;
	QUIET_CODE_COVERAGE = @echo '    ' $@;
	export V
endif
endif

# top-level rule
all: $(PROG)

# build and run the tests
.PHONY: test
test: CXXFLAGS += $(CODE_COVERAGE_CXX_FLAGS)
test: LDFLAGS += $(CODE_COVERAGE_LD_FLAGS)
test: CXXFLAGS += -pthread
test: LDFLAGS += -pthread
test: test_build
test: test_run
# build the tests
test_build: $(TEST_PROG)
# run the tests
test_run:
	./$(TEST_PROG)

# run tests then generate code coverage report
test_and_generate_code_coverage_report: test
test_and_generate_code_coverage_report: generate_code_coverage_report
# generate code coverage reports
generate_code_coverage_report: generate_code_coverage_report_xml
generate_code_coverage_report: generate_code_coverage_report_html
# generate a report in xml
generate_code_coverage_report_xml:
	$(QUIET_CODE_COVERAGE)gcovr --branches --xml-pretty -r . $(CODE_COVERAGE_EXCLUDE_FILES) -o gcovr-report.xml
# generate a report in xml
generate_code_coverage_report_html:
	$(QUIET_CODE_COVERAGE)gcovr --branches -r . --html --html-details $(CODE_COVERAGE_EXCLUDE_FILES) -o gcovr-report.html
# run gcov on all the source files
run_gcov:
	$(GCOV) $(foreach source, $(filter-out main.cpp, $(SOURCES)), $(source)) -lp

# run the tests in debug mode
test_debug: CXXFLAGS += -g
test_debug: test

# compile the program in debug mode
debug: CXXFLAGS += -g
debug: $(PROG)

# run the tests with compiler optimization
test_opt: CXXFLAGS += -O3
test_opt: test

# compile the program with compiler optimization
opt: CXXFLAGS += -O3
opt: $(PROG)

# run the tests on release ready code
test_release: CPPFLAGS += -D NDEBUG
test_release: test_opt

# compile release ready code
release: CPPFLAGS += -D NDEBUG
release: opt
# uncomment the following line to automatically clean up unneeded generated files
release: cleanAllExceptMainExec

# run the tests for gprof profiling
test_gprof: CXXFLAGS += -g -pg
test_gprof: test

# compile the program for gprof profiling
gprof: CXXFLAGS += -g -pg
gprof: $(PROG)

# compile google test
GTEST_HEADERS = $(GTEST_DIR)/include/gtest/*.h \
                $(GTEST_DIR)/include/gtest/internal/*.h
GTEST_SRCS_ = $(GTEST_DIR)/src/*.cc $(GTEST_DIR)/src/*.h $(GTEST_HEADERS)

gtest-all.o : $(GTEST_SRCS_)
	$(QUIET_CXX)$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest-all.cc

gtest_main.o : $(GTEST_SRCS_)
	$(QUIET_CXX)$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) $(CXXFLAGS) -c \
            $(GTEST_DIR)/src/gtest_main.cc

gtest.a : gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gtest_main.a : gtest-all.o gtest_main.o
	$(AR) $(ARFLAGS) $@ $^

# compile google mock
GMOCK_HEADERS = $(GMOCK_DIR)/include/gmock/*.h \
                $(GMOCK_DIR)/include/gmock/internal/*.h \
                $(GTEST_HEADERS)

GMOCK_SRCS_ = $(GMOCK_DIR)/src/*.cc $(GMOCK_HEADERS)

gmock-all.o : $(GMOCK_SRCS_)
	$(QUIET_CXX)$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) -I$(GMOCK_DIR) $(CXXFLAGS) \
            -c $(GMOCK_DIR)/src/gmock-all.cc

gmock_main.o : $(GMOCK_SRCS_)
	$(QUIET_CXX)$(CXX) $(CPPFLAGS) -I$(GTEST_DIR) -I$(GMOCK_DIR) $(CXXFLAGS) \
            -c $(GMOCK_DIR)/src/gmock_main.cc

gmock.a : gmock-all.o gtest-all.o
	$(AR) $(ARFLAGS) $@ $^

gmock_main.a : gmock-all.o gtest-all.o gmock_main.o
	$(AR) $(ARFLAGS) $@ $^


# rule to link program
$(PROG): $(OBJS)
	$(QUIET_LINK)$(CXX) $(LDFLAGS) $(CPPFLAGS) $(ELDFLAGS) $(OBJS) $(LINKEDOBJS) -o $(PROG) $(LIBS)

# rule to link tests
$(TEST_PROG): $(OBJS_MINUS_MAIN) $(TEST_OBJS) $(GTEST_HEADERS) $(GMOCK_HEADERS) gmock_main.a
	$(QUIET_LINK)$(CXX) $(LDFLAGS) $(CPPFLAGS) $(ELDFLAGS) gmock_main.a $(TEST_OBJS) $(OBJS_MINUS_MAIN) $(LINKEDOBJS) -o $(TEST_PROG) $(LIBS)

# rule to compile object files and automatically generate dependency files
define cc-command
	$(QUIET_CXX)$(CXX) $(CXXFLAGS) $(EXXFLAGS) $(CPPFLAGS) -c $< -MMD > $*.d
endef
# compile .c files
.c.o:
	$(cc-command)
# compile .cpp files
.cpp.o:
	$(cc-command)

# include dependency files
-include $(DEPS)
-include $(TEST_DEPS)

.PHONY: setup
setup:
	chmod +x $(SETUP_SCRIPT)
	./$(SETUP_SCRIPT)

.PHONY: remove_sample_code
remove_sample_code:
	chmod +x $(REMOVE_SAMPLE_CODE_SCRIPT)
	./$(REMOVE_SAMPLE_CODE_SCRIPT)

# clean up targets
.PHONY: clean cleanObj cleanAllObj cleanTests cleanAllExceptMainExec cleanAll cleanCodeCoverage

cleanCodeCoverage:
	$(RM) $(CODE_COVERAGE_FILES)

# remove object files and dependency files, but keep the executable
clean:
	$(RM) $(OBJS) $(DEPS)

# only remove the object files
cleanObj:
	$(RM) $(OBJS)

# remove the test objects
cleanAllObj: cleanObj
cleanAllObj:
	$(RM) $(TEST_OBJS)

# remove all generated test files
cleanTests:
	$(RM) $(TEST_PROG) $(TEST_OBJS) $(TEST_DEPS)
	
# remove all generated files except for the main executable
cleanAllExceptMainExec: cleanTests
cleanAllExceptMainExec: clean
cleanAllExceptMainExec: cleanCodeCoverage

# remove all generated files
cleanAll: cleanAllExceptMainExec
cleanAll:
	$(RM) $(PROG)

cleanGoogleTest:
	$(RM) gtest*.o gtest*.a gmock*.o gmock*.a
