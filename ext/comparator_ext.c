#include "ruby.h"

// Allocate space for this module
VALUE ComparatorExt = Qnil;

// Prototype for initialization method
void Init_comparator_ext();

// Prototype for test1 method
VALUE method_test1(VALUE self);

// Initialize module
void Init_mytest() {
  MyText = rb_define_module("MyTest");
  rb_define_method(MyTest, "test1", method_test1, 0);
}

VALUE method_test1(VALUE self) {
  int x = 10;
  return INT2NUM(x);
}
