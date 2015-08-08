#include "Example.h"

Example::Example(int val_)
: val{val_}
{}

int Example::get_val()
{
  return val;
}

void Example::set_val(int val_)
{
  val = val_;
}