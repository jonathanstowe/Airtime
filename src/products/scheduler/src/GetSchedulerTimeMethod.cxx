/*------------------------------------------------------------------------------

    Copyright (c) 2010 Sourcefabric O.P.S.
 
    This file is part of the Campcaster project.
    http://campcaster.sourcefabric.org/
 
    Campcaster is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
  
    Campcaster is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
    along with Campcaster; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
------------------------------------------------------------------------------*/

/* ============================================================ include files */

#ifdef HAVE_CONFIG_H
#include "configure.h"
#endif

#ifdef HAVE_TIME_H
#include <time.h>
#else
#error need time.h
#endif


#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/date_time/gregorian/gregorian.hpp>

#include "LiveSupport/StorageClient/StorageClientInterface.h"
#include "LiveSupport/StorageClient/StorageClientFactory.h"
#include "LiveSupport/Core/TimeConversion.h"
#include "LiveSupport/Core/XmlRpcTools.h"

#include "GetSchedulerTimeMethod.h"


using namespace boost::posix_time;
using namespace boost::gregorian;

using namespace LiveSupport;
using namespace LiveSupport::Core;
using namespace LiveSupport::StorageClient;

using namespace LiveSupport::Scheduler;

/* ===================================================  local data structures */


/* ================================================  local constants & macros */

/*------------------------------------------------------------------------------
 *  The name of this XML-RPC method.
 *----------------------------------------------------------------------------*/
const std::string GetSchedulerTimeMethod::methodName 
                                                = "getSchedulerTime";

/*------------------------------------------------------------------------------
 *  The ID of this method for error reporting purposes.
 *----------------------------------------------------------------------------*/
const int GetSchedulerTimeMethod::errorId = 1900;


/* ===============================================  local function prototypes */


/* =============================================================  module code */

/*------------------------------------------------------------------------------
 *  Construct the method and register it right away.
 *----------------------------------------------------------------------------*/
GetSchedulerTimeMethod :: GetSchedulerTimeMethod (
                        Ptr<XmlRpc::XmlRpcServer>::Ref xmlRpcServer)   throw()
    : XmlRpc::XmlRpcServerMethod(methodName, xmlRpcServer.get())
{
}

 
/*------------------------------------------------------------------------------
 *  Execute the stop XML-RPC function call.
 *----------------------------------------------------------------------------*/
void
GetSchedulerTimeMethod :: execute(XmlRpc::XmlRpcValue  & rootParameter,
                              XmlRpc::XmlRpcValue  & returnValue)
                                                throw (XmlRpc::XmlRpcException)
{
    Ptr<ptime>::Ref schedulerPTime = TimeConversion::now();
    struct tm schedulerTime;
    TimeConversion::ptimeToTm(schedulerPTime, schedulerTime);
    returnValue["schedulerTime"] = & schedulerTime;
}

