/// \file
/// \brief Contains the NAT-type detection code for the client
///
/// This file is part of RakNet Copyright 2003 Jenkins Software LLC
///
/// Usage of RakNet is subject to the appropriate license agreement.


#ifndef __NAT_TYPE_DETECTION_CLIENT_H
#define __NAT_TYPE_DETECTION_CLIENT_H

#include "RakNetTypes.h"
#include "Export.h"
#include "PluginInterface2.h"
#include "PacketPriority.h"
#include "SocketIncludes.h"
#include "DS_OrderedList.h"
#include "RakString.h"
#include "NatTypeDetectionCommon.h"

class RakPeerInterface;
struct Packet;

namespace RakNet
{
	/// \brief Client code for NatTypeDetection
	/// \details See NatTypeDetectionServer.h for algorithm
	/// To use, just connect to the server, and call DetectNAT
	/// You will get back ID_NAT_TYPE_DETECTION_RESULT with one of the enumerated values of NATTypeDetectionResult found in NATTypeDetectionCommon.h
	/// See also http://www.jenkinssoftware.com/raknet/manual/natpunchthrough.html
	/// \sa NatPunchthroughClient
	/// \sa NatTypeDetectionServer
	/// \ingroup NAT_TYPE_DETECTION_GROUP
	class RAK_DLL_EXPORT NatTypeDetectionClient : public PluginInterface2
	{
	public:
		// Constructor
		NatTypeDetectionClient();

		// Destructor
		virtual ~NatTypeDetectionClient();

		/// Send the message to the server to detect the nat type
		/// Server must be running NatTypeDetectionServer
		/// We must already be connected to the server
		/// \param[in] serverAddress address of the server
		void DetectNATType(SystemAddress _serverAddress);

		/// \internal For plugin handling
		virtual void Update(void);

		/// \internal For plugin handling
		virtual PluginReceiveResult OnReceive(Packet *packet);

		virtual void OnClosedConnection(SystemAddress systemAddress, RakNetGUID rakNetGUID, PI2_LostConnectionReason lostConnectionReason );

	protected:
		SOCKET c2;
		unsigned short c2Port;
		void Shutdown(void);
		void OnCompletion(NATTypeDetectionResult result);
		bool IsInProgress(void) const;

		void OnTestPortRestricted(Packet *packet);
		SystemAddress serverAddress;
	};


}


#endif
