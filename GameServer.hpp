#ifndef GAME_SERVER_HPP_INCLUDED
#define GAME_SERVER_HPP_INCLUDED

#include "Common.hpp"
#include "DelayedHost.hpp"
#include <SFML/System/Time.hpp>
#include <map>

class GameServer
{
public:
        struct Player
        {
                explicit Player(Peer peer = Peer());

                Peer peer;
                PlayerState state;
                PlayerInput input;
        };

        explicit GameServer();

        void update(sf::Time delta);

        bool create();
        bool isRunning();

private:
        void updatePlayers(sf::Time delta);

        void onConnect(Peer& peer);
        void onDisconnect(Peer& peer);
        void onReceive(Peer& peer, Packet& packet);

        void onReceiveInput(Peer& peer, Packet& packet);

private:
        const Uint16 mPort;

        DelayedHost mHost;
        bool mRunning;

        std::map<Uint32, Player> mPlayers;
};

#endif // GAME_SERVER_HPP_INCLUDED
