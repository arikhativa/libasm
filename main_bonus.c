
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

#include "libasm_bonus.h"

#define SECTION(x) printf(" --------- %s ---------\n", x);

void print_section(const char *title);

int main(void)
{
    print_section("ft_atoi_base");
    int ret = ft_atoi_base("     + 123", "12");
    printf("%d\n", ret);
    print_section("done");
    // int tt = atoi("   123");
    // printf("%d\n", tt);

    return (0);
}

void print_section(const char *title)
{
    int title_length = strlen(title);
    int padding_length = (80 - title_length - 2) / 2; // 2 for the spaces around the title
    for (int i = 0; i < padding_length; i++)
    {
        putchar('-');
    }
    printf(" %s ", title);
    for (int i = 0; i < padding_length; i++)
    {
        putchar('-');
    }
    if ((80 - title_length - 2) % 2 == 1)
    {
        putchar('-');
    }
    if (strcmp(title, "done") == 0)
    {
        putchar('\n');
    }
    putchar('\n');
}