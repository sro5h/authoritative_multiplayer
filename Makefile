CXX = g++
RM = rm
CXXFLAGS = -I. -Wall -Wextra -std=c++14
LDFLAGS = -lenet -lsfml-graphics -lsfml-window -lsfml-system

CLIENT = cl.out
CLIENT_HEADERS = GameClient.hpp
CLIENT_SOURCES = client.cpp GameClient.cpp
CLIENT_OBJECTS = $(subst .cpp,.o,$(CLIENT_SOURCES))

SERVER = sv.out
SERVER_HEADERS = GameServer.hpp
SERVER_SOURCES = server.cpp GameServer.cpp
SERVER_OBJECTS = $(subst .cpp,.o,$(SERVER_SOURCES))

COMMON_HEADERS = Event.hpp Packet.hpp Host.hpp Peer.hpp Common.hpp\
                 DelayedHost.hpp
COMMON_SOURCES = Packet.cpp Host.cpp Peer.cpp Common.cpp\
                 DelayedHost.cpp
COMMON_OBJECTS = $(subst .cpp,.o,$(COMMON_SOURCES))

all: $(CLIENT) $(SERVER)

$(CLIENT): $(COMMON_OBJECTS) $(CLIENT_OBJECTS)
	$(CXX) -o $(CLIENT) $(COMMON_OBJECTS) $(CLIENT_OBJECTS) $(CXXFLAGS) $(LDFLAGS)

$(CLIENT_OBJECTS): $(CLIENT_SOURCES) $(CLIENT_HEADERS) $(COMMON_HEADERS)
	$(CXX) -c $(CLIENT_SOURCES) $(CXXFLAGS) $(LDFLAGS)

$(SERVER): $(COMMON_OBJECTS) $(SERVER_OBJECTS)
	$(CXX) -o $(SERVER) $(COMMON_OBJECTS) $(SERVER_OBJECTS) $(CXXFLAGS) $(LDFLAGS)

$(SERVER_OBJECTS): $(SERVER_SOURCES) $(SERVER_HEADERS) $(COMMON_HEADERS)
	$(CXX) -c $(SERVER_SOURCES) $(CXXFLAGS) $(LDFLAGS)

$(COMMON_OBJECTS): $(COMMON_SOURCES) $(COMMON_HEADERS)
	$(CXX) -c $(COMMON_SOURCES) $(CXXFLAGS) $(LDFLAGS)

clean:
	$(RM) $(COMMON_OBJECTS)
	$(RM) $(CLIENT_OBJECTS)
	$(RM) $(CLIENT)
	$(RM) $(SERVER_OBJECTS)
	$(RM) $(SERVER)

.PHONY: clean all
