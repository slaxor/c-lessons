#include <stdio.h>
#include "other.h"
int main(int argc, const char **argv)
{
	struct point oret = other("Hallo");
  printf("%s[%f,%f,%f,%f,]@%08x\n", oret.name, oret.x, oret.y, oret.z, oret.t, &oret);
  return 0;
}

