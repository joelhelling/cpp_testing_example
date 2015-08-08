#ifndef EXAMPLE
#define EXAMPLE

class Example {
public:
  Example(int val_ = 0);

  int get_val();
  void set_val(int val_);

private:
  int val;
};

#endif /*EXAMPLE*/