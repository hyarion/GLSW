TARGET = glsw
LIB = lib$(TARGET).a
INC = $(TARGET).h

SRCDIR = src
LIBDIR = lib
INCDIR = inc
OBJDIR = obj

CXX = gcc
CXXFLAGS = -O2 -s -Wall -Iinc
DELETER = rm -f
COPIER = cp

SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
BIN = $(LIBDIR)/$(LIB)

all: $(OBJDIR) $(LIBDIR) $(BIN)

$(LIBDIR):
	mkdir -p $(LIBDIR)
$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BIN): $(OBJS)
	$(DELETER) $(BIN)
	ar r $(BIN) $(OBJS)
	ranlib $(BIN)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CXX) $(CXXFLAGS) -o $@ -c $<

clean: 
	$(DELETER) $(OBJS) $(BIN)

dist-clean: clean
	rm -rf $(OBJDIR) $(LIBDIR)

.PHONY: all clean
