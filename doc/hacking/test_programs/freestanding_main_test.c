#include "mruby.h"

int main(void) {
    mrb_state *mrb = mrb_open();
    mrb_close(mrb);
    return 0;
}
