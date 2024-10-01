
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

#include "libasm.h"

#define SECTION(x) printf(" --------- %s ---------\n", x);
#define STRLEN(x) printf("`%s` = %d (%d)\n", x, ft_strlen(x), (int)strlen(x));

void print_section(const char *title);

int main(void)
{
    int i;
    char buffer[100];

    i = 0;
    while (i < 100)
        buffer[i++] = 0;

    print_section("ft_strlen");
    STRLEN("\t")
    STRLEN("")
    STRLEN("toto")
    STRLEN("totototo")
    STRLEN("0123456789abcdef")
    STRLEN("42")
    STRLEN("1")
    print_section("done");

    print_section("ft_strcpy");
    printf("`%s` (`toto`)\n", ft_strcpy(buffer, "toto"));
    printf("`%s` (empty)\n", ft_strcpy(buffer, ""));
    printf("`%s` (`long message`)\n", ft_strcpy(buffer, "long message"));
    printf("`%s` (NULL)\n", ft_strcpy(buffer, NULL));
    print_section("done");

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