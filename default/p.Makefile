CFLAGS        = -O

DEST	      = ${HOME}/bin

EXTHDRS	      =

HDRS	      =

LDFLAGS	      =

LIBS	      =

LINKER	      = cc

MAKEFILE      = Makefile

OBJS	      =

PRINT	      = pr

PROGRAM	      = a.out

SRCS	      =

all:		$(PROGRAM)

$(PROGRAM):     $(OBJS) $(LIBS)
		$(LINKER) $(OBJS) $(LIBS) $(LDFLAGS) -o $(PROGRAM)

clean:;		rm -f $(OBJS) $(PROGRAM)

depend:;	mkmf -f $(MAKEFILE) PROGRAM=$(PROGRAM) DEST=$(DEST)

index:;		ctags -wx $(HDRS) $(SRCS)

install:	$(PROGRAM)
		install -s $(PROGRAM) $(DEST)

print:;		$(PRINT) $(HDRS) $(SRCS)

program:        $(PROGRAM)

tags:           $(HDRS) $(SRCS); ctags $(HDRS) $(SRCS)

update:		$(DEST)/$(PROGRAM)

$(DEST)/$(PROGRAM): $(SRCS) $(LIBS) $(HDRS) $(EXTHDRS)
		@make -f $(MAKEFILE) DEST=$(DEST) install
