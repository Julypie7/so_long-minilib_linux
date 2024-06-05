# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ineimatu <ineimatu@student.42barcel>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/17 11:02:24 by ineimatu          #+#    #+#              #
#    Updated: 2024/06/05 11:43:02 by ineimatu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = so_long
MLX = mlx_linux/
NPD = --no-print-directory
PRINTF = ft_printf/
GNL = gnl/
LIBFT = libft/
MLX_A = $(addprefix $(MLX), libmlx.a)
PRINTF_A = $(addprefix $(PRINTF), libft_printf.a)
GNL_A = $(addprefix $(GNL), libgnl.a)
LIBFT_A = $(addprefix $(LIBFT), libft.a)

SRC = main.c \
	  map.c \
	  pars_map.c \
	  map_utils.c \
	  graphics.c \
	  controls.c \
	  controls_check.c \
	  ft_realloc.c \

OBJ = $(SRC:.c=.o)
	
CC =  cc

INCLUDES = -I includes -I $(LIBFT)libft.h -I $(PRINTF)ft_printf.h -I $(GNL)get_next_line.h

CCFLAGS = -Wextra -Werror -Wall $(INCLUDES) 

all:
	@$(MAKE) -C $(LIBFT) $(NPD)
	@$(MAKE) -C $(PRINTF) $(NPD)
	@$(MAKE) -C $(GNL) $(NPD)
	@$(MAKE) -C $(MLX) $(NPD)
	@$(MAKE) $(NAME) $(NPD)

$(NAME):	$(OBJ)
	$(CC) $(CCFLAGS) $(OBJ) -L$(LIBFT) -lft -L$(PRINTF) -lft_printf -L$(GNL) -lgnl -L$(MLX) -Lmlx_linux -lmlx_Linux -L/usr/lib -Imlx_linux -lXext -lX11 -lm -lz -o $(NAME)

%.o:		%.c Makefile includes/so_long.h includes/so_l_utils.h $(LIBFT_A) $(PRINTF_A) $(GNL_A) $(MLX_A)
			$(CC) $(CCFLAGS) -Imlx_linux -O3 -c $< -o $(<:.c=.o)

clean:
			rm -f $(OBJ)
			$(MAKE) clean -s -C $(PRINTF)
			$(MAKE) clean -s -C $(GNL)
			$(MAKE) clean -s -C $(LIBFT)

fclean:		clean
			$(MAKE) clean -s -C $(MLX)
			$(MAKE) fclean -s -C $(GNL)
			$(MAKE) fclean -s -C $(PRINTF)
			$(MAKE) fclean -s -C $(LIBFT)
			rm -f $(NAME)

re:	fclean all

.PHONY: all clean fclean re
