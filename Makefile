CXX = c++ -g -fsanitize=address 
CXXFLAGS = -Wall -Wextra -Werror -std=c++98 -Iinclude
SRC_DIR = src
BUILD_DIR = build
TARGET = webserv
CONDIRS = config/cgi_comm config/sockets config/html_default_error_files config/html_generated_files

SRCS = $(wildcard $(SRC_DIR)/**/*.cpp $(SRC_DIR)/*.cpp)
OBJS = $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRCS))

all: mkdir $(TARGET)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET)

rmdi:
	rm -rf $(CONDIRS)

mkdir:
	@mkdir -p $(CONDIRS)

clean:
	rm -rf $(BUILD_DIR) $(TARGET)

fclean: rmdi clean

re: fclean all

.PHONY: all clean fclean re mkdir
