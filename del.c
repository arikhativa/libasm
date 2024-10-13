#include <stdbool.h>

bool is_valid_base(char *base)
{
    int i, j;

    // Base must contain at least 2 characters
    for (i = 0; base[i]; i++)
    {
        // Base cannot contain '+' or '-' or whitespaces
        if (base[i] == '+' || base[i] == '-' || base[i] <= ' ')
            return false;
        // Check if the base contains duplicate characters
        for (j = i + 1; base[j]; j++)
        {
            if (base[i] == base[j])
                return false;
        }
    }
    // Base size must be greater than 1
    return (i > 1);
}

int get_value_from_base(char c, char *base)
{
    int i = 0;
    while (base[i])
    {
        if (base[i] == c)
            return i;
        i++;
    }
    return -1; // Character not found in the base
}

int ft_atoi_base(char *str, char *base)
{
    int sign = 1;
    int result = 0;
    int base_len;

    // Check if the base is valid
    if (!is_valid_base(base))
        return 0;

    // Skip whitespaces
    while (*str == ' ' || (*str >= 9 && *str <= 13))
        str++;

    // Handle optional '+' and '-' signs
    while (*str == '+' || *str == '-')
    {
        if (*str == '-')
            sign *= -1;
        str++;
    }

    base_len = 0;
    while (base[base_len])
        base_len++;

    // Convert the number
    int value;
    while ((value = get_value_from_base(*str, base)) != -1)
    {
        result = result * base_len + value;
        str++;
    }

    return result * sign;
}
#include <stdlib.h>
#include <stdio.h>
int main()
{
    // int ret = ft_atoi_base("101", "01");
    int ret = atoi(0);
    printf("%d\n", ret);
    return 0;
}