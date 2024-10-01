
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>

#include "libasm.h"

#define SECTION(x) printf(" --------- %s ---------\n", x);
#define STRLEN(x) printf("`%s` = %d (%d)\n", x, ft_strlen(x), (int)strlen(x));
#define STRCMP(a, b) printf("`%s`:`%s` = %d (%d)\n", a, b, ft_strcmp(a, b), strcmp(a, b));
#define WRITE(s, x) printf("\t-\t%ld (`%s`:%ld)\n", ft_write(STDOUT_FILENO, s, x), s, x);

#define READ(b, x)                        \
    r = ft_read(STDIN_FILENO, buffer, x); \
    printf("`%s`:%ld\n", buffer, r);

#define DUP(s)                       \
    tmp = ft_strdup(s);              \
    printf("`%s` (`%s`)\n", tmp, s); \
    free(tmp);                       \
    tmp = NULL;

void print_section(const char *title);

int main(void)
{
    char *null = 0;
    long r;
    int i;
    char buffer[100];
    char *tmp;
    char *tmp2;

    i = 0;
    while (i < 100)
        buffer[i++] = 0;

    // print_section("ft_strlen");
    // STRLEN("\t")
    // STRLEN("")
    // STRLEN("toto")
    // STRLEN("totototo")
    // STRLEN("0123456789abcdef")
    // STRLEN("42")
    // STRLEN("1")
    // print_section("done");

    // print_section("ft_strcpy");
    // printf("`%s` (`toto`)\n", ft_strcpy(buffer, "toto"));
    // printf("`%s` (empty)\n", ft_strcpy(buffer, ""));
    // printf("`%s` (`long message`)\n", ft_strcpy(buffer, "long message"));
    // printf("`%s` (NULL)\n", ft_strcpy(buffer, NULL));
    // print_section("done");

    // print_section("ft_strcmp");
    // STRCMP("", "");
    // STRCMP("toto", "toto");
    // STRCMP("", "toto");
    // STRCMP("toto", "");
    // STRCMP("toto", "totobar")
    // printf("`%s`:`%s` = %d\n", "TOTO", null, ft_strcmp("TOTO", null));
    // printf("`%s`:`%s` = %d\n", null, "TOTO", ft_strcmp(null, "TOTO"));
    // printf("`%s`:`%s` = %d\n", null, null, ft_strcmp(null, null));
    // print_section("done");

    // print_section("ft_write");
    // WRITE("toto", 4L)
    // WRITE("totototo", 4L)
    // WRITE("totototo", 8L)
    // WRITE("toto", 2L)
    // print_section("done");

    // print_section("ft_read");
    // READ(buffer, 50)
    // READ(buffer, 25)
    // READ(buffer, 4)
    // READ(buffer, 26)
    // READ(buffer, 14)
    // READ(buffer, 0)
    // print_section("done");

    print_section("ft_strdup");
    tmp2 = ft_strdup("toto");
    printf("%s\n", tmp2);
    // printf("%d\n", (int)tmp2);
    // printf("%s\n", tmp2);
    // DUP(tmp2)
    // free(tmp2);
    // DUP("totobar")
    // DUP("long message")
    // DUP("")
    // DUP(NULL)
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