# compiler
CC := g++
# linker
LD := g++
# preprocessor flags
CPPFLAGS :=
# main compiler flags
CCFLAGS := -std=c++11 -Wall -Wextra -pedantic -Wvla
# extra compiler flags
ECCFLAGS := 
# code coverage compile flags
CODE_COVERAGE_CC_FLAGS := -fprofile-arcs -ftest-coverage -fPIC -O0
# main linker flags
LDFLAGS := -pedantic -Wall
# extra linker flags
ELDFLAGS := 
# code coverage linker flags
CODE_COVERAGE_LD_FLAGS := -lgcov -coverage
# erase files command
RM := rm -f

# executable
PROG := a.out
# source files
SOURCES := $(wildcard *.c *.cpp)
SOURCES := $(filter-out $(wildcard test*), $(SOURCES))
# pre-compiled object files to link against
LINKEDOBJS := 
# object files for each source file
OBJS := $(patsubst %.c, %.o, $(filter %.c, $(SOURCES)))
OBJS += $(patsubst %.cpp, %.o, $(filter %.cpp, $(SOURCES)))
# all objects except for main.o
OBJS_MINUS_MAIN := $(filter-out main.o, $(OBJS))
# dependency files
DEPS = $(OBJS:%.o=%.d)

# test executable
TEST_PROG := test.out
# test source files
TEST_SOURCES := $(wildcard test*.c test*.cpp)
# test object files
TEST_OBJS := $(patsubst %.c, %.o, $(filter %.c, $(TEST_SOURCES)))
TEST_OBJS += $(patsubst %.cpp, %.o, $(filter %.cpp, $(TEST_SOURCES)))
# test dependency files
TEST_DEPS = $(TEST_OBJS:%.o=%.d)

# code coverage files
CODE_COVERAGE_FILES := $(wildcard *.gcda *.gcno gcovr-report*.html)
# code coverage exclude files flags
CODE_COVERAGE_EXCLUDE_FILES := -e 'test_'
CODE_COVERAGE_EXCLUDE_FILES += -e 'submodules/'


# use quiet output
ifneq ($(findstring $(MAKEFLAGS),s),s)
ifndef V
	# QUIET_CC		= @echo '   ' CC $@;
	# QUIET_LINK		= @echo '   ' LD $@;
	export V
endif
endif

# top-level rule
all: $(PROG)

# build and run the tests
test: CCFLAGS += $(CODE_COVERAGE_CC_FLAGS)
test: LDFLAGS += $(CODE_COVERAGE_LD_FLAGS)
test: test_build
test: test_run
# build the tests
test_build: $(TEST_PROG)
# run the tests
test_run:
	./$(TEST_PROG)

# generate code coverage reports
generate_code_coverage_report: test
generate_code_coverage_report: generate_code_coverage_report_xml
generate_code_coverage_report: generate_code_coverage_report_html
# generate a report in xml
generate_code_coverage_report_xml:
	gcovr --branches --xml-pretty -r . $(CODE_COVERAGE_EXCLUDE_FILES) -o gcovr-report.xml
# generate a report in xml
generate_code_coverage_report_html:
	gcovr --branches -r . --html --html-details $(CODE_COVERAGE_EXCLUDE_FILES) -o gcovr-report.html

# run the tests in debug mode
test_debug: CCFLAGS += -g
test_debug: test

# compile the program in debug mode
debug: CCFLAGS += -g
debug: $(PROG)

# run the tests with compiler optimization
test_opt: CCFLAGS += -O3
test_opt: test

# compile the program with compiler optimization
opt: CCFLAGS += -O3
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
test_gprof: CCFLAGS += -g -pg
test_gprof: test

# compile the program for gprof profiling
gprof: CCFLAGS += -g -pg
gprof: $(PROG)

# rule to link program
$(PROG): $(OBJS)
	$(QUIET_LINK)$(LD) $(LDFLAGS) $(CPPFLAGS) $(ELDFLAGS) $(OBJS) $(LINKEDOBJS) -o $(PROG)

# rule to link tests
$(TEST_PROG): $(OBJS_MINUS_MAIN) $(TEST_OBJS)
	$(QUIET_LINK)$(LD) $(LDFLAGS) $(CPPFLAGS) $(ELDFLAGS) $(TEST_OBJS) $(OBJS_MINUS_MAIN) $(LINKEDOBJS) -o $(TEST_PROG)

# rule to compile object files and automatically generate dependency files
define cc-command
	$(QUIET_CC)$(CC) $(CCFLAGS) $(ECCFLAGS) $(CPPFLAGS) -c $< -MMD > $*.d
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
