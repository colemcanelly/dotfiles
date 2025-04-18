NAME=colors #$(shell basename $(CURDIR))

BINDIR=./.local/bin
OBJDIR=obj
DEPDIR=dep

SRCDIR=src
INCDIR=include

BIN=$(BINDIR)/$(NAME)

# Compiler settings
CPP=g++
DEPFLAGS := -MP -MMD
OPT := -Ofast
DEBUGFLAGS := -fno-stack-protector -Wstringop-overflow=0 -Wformat-overflow=0
INCLUDE := -I$(INCDIR) -I$(COMMON_INC)

CPPFLAGS := -std=c++17 $(INCLUDE) $(OPT) $(DEPFLAGS) # $(DEBUGFLAGS) -m32
LDLIBS := 


# File list generation
SRCS=$(wildcard $(SRCDIR)/*.cpp)
OBJS=$(patsubst $(SRCDIR)/%.cpp,$(OBJDIR)/%.o,$(SRCS))
DEPS=$(patsubst $(SRCDIR)/%.cpp,$(DEPDIR)/%.d,$(SRCS))


# ###################### Targets ######################
all: $(BIN)


# Link the final binary
$(BIN): $(OBJS) | $(BINDIR)
	@ $(CPP) $(CPPFLAGS) -o $@ $^ $(LDLIBS)
	$(info ./$@)


# Compile to objects
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp | $(OBJDIR) $(DEPDIR)
	$(info $@...)
	@ $(CPP) $(CPPFLAGS) -MF $(DEPDIR)/$*.d -c -o $@ $<


# Create dirs if they don't exist
$(OBJDIR): ; @mkdir -p $(OBJDIR)
$(BINDIR): ; @mkdir -p $(BINDIR)
$(DEPDIR): ; @mkdir -p $(DEPDIR)

.PHONY: clean test

clean:
	rm -f $(OBJDIR)/*.o $(DEPDIR)/*.d $(BINDIR)/*

%:		# Do nothing if an arg is not a `Make Goal`
	@:
