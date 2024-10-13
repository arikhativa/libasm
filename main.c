
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

#include "libasm.h"

#define SECTION(x) printf(" --------- %s ---------\n", x);
#define STRLEN(x) printf("`%s` = %d (%d)\n", x, ft_strlen(x), (int)strlen(x));
#define STRCMP(a, b) printf("`%s`:`%s` = %d (%d)\n", a, b, ft_strcmp(a, b), strcmp(a, b));
#define WRITE(s, x) printf("\t-\t%ld (`%s`:%ld)\n", ft_write(STDOUT_FILENO, s, x), s, x);

#define WRITE_ERR(fd, s, x)      \
    my_ret = ft_write(fd, s, x); \
    my_errno = errno;            \
    lib_ret = write(fd, s, x);   \
    lib_errno = errno;           \
    errno = 0l;                  \
    printf("\t-\tret value: %ld (%ld), errno: %d (%d)\n", my_ret, lib_ret, my_errno, lib_errno);

#define READ_ERR(fd, s, x)      \
    my_ret = ft_read(fd, s, x); \
    my_errno = errno;           \
    lib_ret = read(fd, s, x);   \
    lib_errno = errno;          \
    errno = 0l;                 \
    printf("\t-\tret value: %ld (%ld), errno: %d (%d)\n", my_ret, lib_ret, my_errno, lib_errno);

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

    ssize_t my_ret;
    int my_errno;
    ssize_t lib_ret;
    int lib_errno;

    char *null = 0;
    long r;
    int i;
    char buffer[100];
    char *tmp;
    char *tmp2;

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

    print_section("ft_strcmp");
    STRCMP("", "");
    STRCMP("toto", "toto");
    STRCMP("", "toto");
    STRCMP("toto", "");
    STRCMP("toto", "totobar")
    printf("`%s`:`%s` = %d\n", "TOTO", null, ft_strcmp("TOTO", null));
    printf("`%s`:`%s` = %d\n", null, "TOTO", ft_strcmp(null, "TOTO"));
    printf("`%s`:`%s` = %d\n", null, null, ft_strcmp(null, null));
    print_section("done");

    print_section("ft_write");
    WRITE("toto", 4L)
    WRITE("totototo", 4L)
    WRITE("totototo", 8L)
    WRITE("toto", 2L)
    WRITE("toto", 2L)

    WRITE_ERR(2222, "toto", 4L)
    WRITE_ERR(1, "toto", -1)
    WRITE_ERR(1, null, 1)

    print_section("done");

    print_section("ft_read");

    READ(buffer, 50)
    READ(buffer, 25)
    READ(buffer, 4)
    READ(buffer, 26)
    READ(buffer, 14)
    READ(buffer, 0)
    READ_ERR(2222, buffer, 50)
    READ_ERR(0, buffer, -1)
    print_section("done");

    print_section("ft_strdup");
    DUP(tmp2)
    free(tmp2);
    DUP("totobar")
    DUP("long message")
    DUP("")
    DUP(null)
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