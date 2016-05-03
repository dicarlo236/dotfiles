#Makefile with SDL
appname := MOTORS 

CXX := g++
CXXFLAGS := -Wall -g -std=c++11 #enable all warnings and debugging
LINKER_FLAGS := -lSDL2 

srcfiles := $(shell find . -maxdepth 1 -name "*.cpp") #find all .cpp files
objects  := $(patsubst %.cpp, %.o, $(srcfiles)) #name object files with .o suffix

all: $(appname)

$(appname): $(objects)
	$(CXX) $(CXXFLAGS)  -o $(appname) $(objects) $(LINKER_FLAGS) #g++ is sad unless linker flags are at the end...

depend: .depend

.depend: $(srcfiles)
	rm -f ./.depend
	$(CXX) $(CXXFLAGS)  -MM   $^>>./.depend; $(LINKER_FLAGS)

clean:
	rm -f $(objects)

dist-clean: clean
	rm -f *~ .depend

.PHONY : run
run : $(appname) 
	./$(appname)

include .depend
