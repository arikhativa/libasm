# TODO add 42 signtuer

NAME		=	libasm.a

SRCS		=	ft_strlen.s \
				ft_strcpy.s \
				ft_strcmp.s \
				# ft_write.s \
				# ft_read.s \
				# ft_strdup.s

OBJS		=	$(SRCS:.s=.o)

BONUS_SRCS	=	ft_atoi_base_bonus.s \
				ft_list_size_bonus.s \
				ft_list_push_front_bonus.s \
				ft_list_remove_if_bonus.s \
				ft_list_sort_bonus.s

BONUS_OBJS	=	$(BONUS_SRCS:.s=.o)

NA			=	nasm
NA_FLAGS	=	-f elf64
LD_FLAGS	=	-m elf_x86_64
TEST		=	test
TEST_BONUS	=	test_bonus
CC			=	gcc
CFLAGS 		=	-Wall -Werror -Wextra
ARFLAGS 	=	rc
RMFLAGS 	=	-rf

%.o:			%.s
				$(NA) $(NA_FLAGS) $<

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

clean:
	$(RM) $(RMFLAGS) $(OBJS) $(BONUS_OBJS)

fclean: clean
	$(RM) $(RMFLAGS) $(NAME) $(BONUS) $(TEST) $(TEST_BONUS)

re: fclean $(NAME)

test: $(NAME)
	$(CC) $(FLAGS) -o $(TEST) main.c -L. -lasm
	./$(TEST)

bonus: $(OBJS) $(BONUS_OBJS)
	$(AR) rcs $(NAME) $(OBJS) $(BONUS_OBJS)

test_bonus: bonus
	$(CC) $(FLAGS) -L. -lasm -o $(TEST_BONUS) main_bonus.c
	./$(TEST_BONUS)

.PHONY: clean fclean re test bonus test_bonus