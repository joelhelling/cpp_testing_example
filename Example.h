#ifndef EXAMPLE_H
#define EXAMPLE_H

class Example {
public:
  Example(int val_ = 0);

  int get_val();
  void set_val(int val_);

private:
  int val;
};

#endif /*EXAMPLE_H*/
