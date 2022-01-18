#
#  $Id$
#
#########################
#  Common macros	#
#########################
#CCFLAGS	       += -stdlib=libc++ #-std=c++0x
#LDFLAGS	       += -stdlib=libc++

ifneq ($(findstring darwin,$(OSTYPE)),)
  NVCCFLAGS    += -m64
  LDFLAGS      += $(NVCCFLAGS)
endif

INSTALL		= install
MAKEFILE	= Makefile

#########################
#  Making rules		#
#########################
all:		$(PROGRAM)

$(PROGRAM):     $(OBJS)
		$(LINKER) $(LDFLAGS) $(INCDIRS)	$(OBJS) $(LIBS) -o $@

.c.o:
		$(CC) $(CPPFLAGS) $(CFLAGS) $(INCDIRS) -c $<

.cc.o:
		$(CXX) $(CPPFLAGS) $(CCFLAGS) $(INCDIRS) -c $<

.cpp.o:
		$(CXX) $(CPPFLAGS) $(CCFLAGS) $(INCDIRS) -c $<

.cu.o:
		$(NVCC) $(CPPFLAGS) $(NVCCFLAGS) $(INCDIRS) -c $<

install:	$(PROGRAM)
		$(INSTALL) -m 0755 $(PROGRAM) $(DEST)/$(PROGRAM)

clean:
		$(RM) -r $(OBJS) $(PROGRAM)

depend:
		mkmf $(INCDIRS) -f $(MAKEFILE)

index:
		ctags -wx $(HDRS) $(SRCS)

tags:           $(HDRS) $(SRCS)
		ctags $(HDRS) $(SRCS)

link:		$(OBJS)
		$(RM) $(PROGRAM); make $(PROGRAM)

doc:		$(HDRS) $(SRCS) doxygen.cfg
		doxygen doxygen.cfg

doxygen.cfg:
		doxygen -g $@

#update:		$(DEST)/$(PROGRAM)
#
#$(DEST)/$(PROGRAM): $(SRCS) $(HDRS) $(EXTHDRS)
#		@make -f $(MAKEFILE) DEST=$(DEST) install
