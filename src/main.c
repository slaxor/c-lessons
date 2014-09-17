#include <stdio.h>
#include "other.h"
int main(int argc, const char **argv)
{
	if (argc < 2)
	{
		fprintf(stderr, "error: At least one argument needed\n");
		return 1;
	}
	else
	{
		point oret = other(argv[1]);
		printf("%s[%f,%f,%f,%f,]@%08x\n", oret.name, oret.x, oret.y, oret.z, oret.t, &oret);
		return 0;
	}
}

