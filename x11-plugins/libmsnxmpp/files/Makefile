PIDGIN_PREFIX=`equery list --format='$$name-$$version' pidgin`
libmsnxmpp.so:
	gcc -fPIC -Wall `pkg-config --cflags --libs glib-2.0, purple` -I /usr/include/libxml2 -I ${PIDGIN_PREFIX}/libpurple/protocols/jabber/ -I ${PIDGIN_PREFIX}/libpurple/ -c libmsnxmpp.c -o libmsnxmpp.o
	gcc -shared `pkg-config --cflags --libs glib-2.0, purple` -I /usr/include/libxml2 -I ${PIDGIN_PREFIX}/libpurple/protocols/jabber/ -I ${PIDGIN_PREFIX}/libpurple/ -Wl,-soname,libmsnxmpp.so -o libmsnxmpp.so  libmsnxmpp.o
