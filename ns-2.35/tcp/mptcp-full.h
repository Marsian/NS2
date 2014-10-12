/*
 * Copyright (C) 2011 WIDE Project.  All rights reserved.
 *
 * Yoshifumi Nishida  <nishida@sfc.wide.ad.jp>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the project nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

#ifndef ns_mptcp_full_h
#define ns_mptcp_full_h

#include "tcp.h"
#include "rq.h"
#include "tcp-full.h"

#include <vector>
class MptcpAgent;
struct dsn_mapping
{
  dsn_mapping (int dseq, int curseq, int len):sentseq (0)
  {
    dseqnum = dseq;
    sseqnum = curseq;
    length = len;
  }
  int sseqnum;
  int dseqnum;
  int length;
  int sentseq;
};

// from RFC6824
const int MPTCP_CAPABLEOPTION_SIZE = 12;
const int MPTCP_JOINOPTION_SIZE = 16;
const int MPTCP_ACKOPTION_SIZE = 20;
const int MPTCP_DATAOPTION_SIZE = 20;

class MpFullTcpAgent;

class MpFullTcpAgent:public SackFullTcpAgent
{
public:
  MpFullTcpAgent ():mptcp_core_ (NULL), mptcp_primary_ (false),
    mptcp_allow_slowstart_ (true), mptcp_last_cwnd_(0)
  {
  }

  /* multipath TCP */
  double mptcp_get_cwnd ()
  {
    if (fastrecov_){
        /* use ssthresh value for flows in fast retransmit
           see Section 3 for RFC6356 */
        return (double) ssthresh_;
    }
    return (double) cwnd_;
  }
  double mptcp_get_last_cwnd() 
  {
    return mptcp_last_cwnd_;
  }
  void mptcp_set_last_cwnd(double cwnd_) 
  {
    mptcp_last_cwnd_ = cwnd_;
  }
  int mptcp_get_ssthresh ()
  {
    return (int) ssthresh_;
  }
  int mptcp_get_maxseq ()
  {
    return (int) maxseq_;
  }
  int mptcp_get_highest_ack ()
  {
    return (int) highest_ack_;
  }
  double mptcp_get_srtt ()
  {
    return (double) ((t_srtt_ >> T_SRTT_BITS) * tcp_tick_);
  }
  double mptcp_get_backoff ()
  {
    return (int) t_backoff_;
  }
  int mptcp_get_numdupacks ()
  {
    return (int) dupacks_;
  }

  void mptcp_set_core (MptcpAgent *);
  void mptcp_set_primary ()
  {
    mptcp_primary_ = true;
  }
  void mptcp_add_mapping (int dseqnum, int length);
  void mptcp_recv_add_mapping (int dseqnum, int sseqnum, int length);
  void mptcp_remove_mapping (int seqnum);
  void mptcp_set_slowstart (bool value)
  {
    mptcp_allow_slowstart_ = value;
  }
  int mptcp_recv_getack (int acknow);
  bool mptcp_is_primary ()
  {
    return mptcp_primary_;
  }
  bool mpcapable_;
  bool mpjoin_;
  bool mpdata_;
  bool mpaddr_;
  bool mpack_;
protected:
  void opencwnd ();
  void dupack_action ();
  void timeout_action ();
  int headersize ();            // a tcp header w/opts
  virtual void sendpacket (int seq, int ack, int flags, int dlen, int why,
                           Packet * p = 0);
  void prpkt (Packet *);        // print packet (debugging helper)

  /* multipath TCP */
  MptcpAgent *mptcp_core_;
  bool mptcp_primary_;
  bool mptcp_allow_slowstart_;
  int mptcp_prev_ackno_;     // previous highest ack 
  int mptcp_prev_sqminseq_;  // previous minseq in sack block
  int mptcp_prev_sqtotal_;   // previous total bytes in sack blocks
  int mptcp_option_size_;
  int mptcp_last_cwnd_;
  vector < dsn_mapping > mptcp_dsnmap_;
  vector < dsn_mapping > mptcp_recv_dsnmap_;
};

#endif
