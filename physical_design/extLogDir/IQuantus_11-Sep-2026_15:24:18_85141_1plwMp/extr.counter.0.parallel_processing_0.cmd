#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Sep 11 15:24:45 2026                
#                                                     
#######################################################

#@(#)CDS: Innovus v25.13-s088_1 (64bit) 03/26/2026 12:37 (Linux 4.18.0-305.el8.x86_64)
#@(#)CDS: NanoRoute 25.13-s088_1 NR260309-1855/25_13-UB (database version 18.20.683) {superthreading v2.20}
#@(#)CDS: AAE 25.13-s023 (64bit) 03/26/2026 (Linux 4.18.0-305.el8.x86_64)
#@(#)CDS: CTE 25.13-s044_1 () Mar 24 2026 17:45:14 ( )
#@(#)CDS: SYNTECH 25.13-s012_1 () Mar 10 2026 03:01:02 ( )
#@(#)CDS: CPE v25.13-s019
#@(#)CDS: IQuantus/TQuantus 24.1.0-s476 (64bit) Wed Feb 11 22:11:27 PST 2026 (Linux 4.18.0-305.el8.x86_64)

#@ source /home/icd1/workspace/counter_design_45nm/physical_design/.85141_4fb1ca82-bcb1-438c-bf34-c012f4c21f44_soce_slave_0
#@ Begin verbose source (pre): source /home/icd1/workspace/counter_design_45nm/physical_design/.85141_4fb1ca82-bcb1-438c-bf34-c012f4c21f44_soce_slave_0
eval_legacy {unlogCommand eval_legacy}
eval_legacy {
catch {set ::env(AMBIT_BDF_PATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/etc/innovus/syntechEtc/bdfc:/home/icd1/cadence/installs/DDI251/INNOVUS251/etc/innovus/cteng/bdfc"}
catch {set ::env(BLT_LIBRARY) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/tcltools/icd8.6.4/lib/blt2.4"}
catch {set ::env(CADENCE_ROOT) "/home/icd1/cadence"}
catch {set ::env(CDN_SYNTH_ROOT) "/home/admin/cadence/installs/DDI251/INNOVUS251/tools.lnx86"}
catch {set ::env(CDSHOME) "/home/icd1/cadence/installs/DDI251"}
catch {set ::env(CDS_AUTO_64BIT) "ALL"}
catch {set ::env(CDS_INST_DIR) "/home/icd1/cadence/installs/DDI251"}
catch {set ::env(CDS_LANG) "en_US.UTF-8"}
catch {set ::env(CDS_LIC_FILE) "/home/icd1/cadence/lisence/cadence.dat"}
catch {set ::env(CDS_SET_LOCALE) "C"}
catch {set ::env(CDS_SKIP_OS_CHECK_ON_STARTUP) "1"}
catch {set ::env(CDS_W3264_LIBPATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/libstdc++6/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/share/oa/lib/lnx86/opt:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/tcltools/icd8.6.4/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/innovus/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/Qt/v5//64bit/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/PROTOBUF/tools.lnx86/TPtools/openssl/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/pvs/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mesalib/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/inca/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mdl/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mkl/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/tcltk-8.6.8/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/fmc/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/vxe/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/tensorflow/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mlpack/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/liberate/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/boost/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/tbb/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/libevent/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/yaml-cpp/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/leveldb/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/zmq/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/extraction/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/capnproto-0.8.0/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/nng/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/python/64bit/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mmsim/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/torchscatter/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/torchsparse/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/libtorch/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/cdsgcc/gcc/12.3/install/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/imagemagick/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/imagemagick/lib/ImageMagick-6.6.1/modules-Q16/coders:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/libffi/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/IntegrityPlanner/jre/lib/server:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/IntegrityPlanner/jre/lib/server/natives/linux-amd64:/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/lib/64bit/RHEL/RHEL8"}
catch {set ::env(COLORTERM) "truecolor"}
catch {set ::env(DBUS_SESSION_BUS_ADDRESS) "unix:path=/run/user/1001/bus"}
catch {set ::env(DDIROOT) "/home/icd1/cadence/installs/DDI251"}
catch {set ::env(DESKTOP_SESSION) "xfce"}
catch {set ::env(DISPLAY) "eda:10.0"}
catch {set ::env(EDITOR) "gedit"}
catch {set ::env(ENCOUNTER) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/innovus"}
catch {set ::env(HISTCONTROL) "ignoredups"}
catch {set ::env(HISTSIZE) "1000"}
catch {set ::env(HOME) "/home/icd1"}
catch {set ::env(ICROOT) "/home/icd1/cadence/installs/DDI251"}
catch {set ::env(INNOVUS) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/innovus"}
catch {set ::env(INSTALL_ROOT) "/home/icd1/cadence/installs"}
catch {set ::env(JAVA_HOME) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/IntegrityPlanner/jre"}
catch {set ::env(LANG) "C"}
catch {set ::env(LC_ALL) "C"}
catch {set ::env(LD_LIBRARY_PATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/libstdc++6/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/share/oa/lib/lnx86/opt:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/tcltools/icd8.6.4/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/innovus/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/Qt/v5//64bit/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/PROTOBUF/tools.lnx86/TPtools/openssl/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/pvs/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mesalib/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/inca/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mdl/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mkl/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/tcltk-8.6.8/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/fmc/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/vxe/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/tensorflow/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mlpack/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/liberate/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/boost/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/tbb/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/libevent/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/yaml-cpp/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/leveldb/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/zmq/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/extraction/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/capnproto-0.8.0/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/nng/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/python/64bit/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/mmsim/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/torchscatter/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/torchsparse/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/libtorch/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/cdsgcc/gcc/12.3/install/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/imagemagick/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/imagemagick/lib/ImageMagick-6.6.1/modules-Q16/coders:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/lib/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/lib:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/TPtools/libffi/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/IntegrityPlanner/jre/lib/server:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/IntegrityPlanner/jre/lib/server/natives/linux-amd64:/lib64:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/lib/64bit/RHEL/RHEL8"}
catch {set ::env(LM_LICENSE_FILE) "/home/icd1/cadence/lisence/cadence.dat"}
catch {set ::env(LOADEDMODULES) ""}
catch {set ::env(LOGNAME) "icd1"}
catch {set ::env(MAGICK_CODER_MODULE_PATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/imagemagick/lib/ImageMagick-6.6.1/modules-Q16/coders"}
catch {set ::env(MAIL) "/var/spool/mail/icd1"}
catch {set ::env(MANPATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/innovus/stylus/man:/home/icd1/cadence/installs/DDI251/INNOVUS251/share/tcltools/man"}
catch {set ::env(MODULEPATH) "/etc/scl/modulefiles:/etc/scl/modulefiles:/etc/scl/modulefiles:/etc/scl/modulefiles:/etc/scl/modulefiles:/usr/share/Modules/modulefiles:/etc/modulefiles:/usr/share/modulefiles"}
catch {set ::env(MODULEPATH_modshare) "/usr/share/Modules/modulefiles:2:/etc/modulefiles:2:/usr/share/modulefiles:2"}
catch {set ::env(MODULESHOME) "/usr/share/Modules"}
catch {set ::env(MODULES_CMD) "/usr/share/Modules/libexec/modulecmd.tcl"}
catch {set ::env(MODULES_RUN_QUARANTINE) "LD_LIBRARY_PATH LD_PRELOAD"}
catch {set ::env(OLDPWD) "/home/icd1/workspace/counter_design_45nm"}
catch {set ::env(ORBIT_HOME) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/IntegrityPlanner"}
catch {set ::env(PANEL_GDK_CORE_DEVICE_EVENTS) "0"}
catch {set ::env(PATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/bin:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/bin/64bit:/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/cadence/installs/DDI251/GENUS251/tools.lnx86/bin/64bit:/home/icd1/cadence/installs/DDI251/GENUS251/tools.lnx86/bin:/home/icd1/cadence/installs/DDI251/GENUS251/bin:/home/icd1/cadence/installs/DDI251/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/bin:/usr/share/Modules/bin:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin"}
catch {set ::env(PDK_ROOT) "/home/icd1/cadence/pdk"}
catch {set ::env(PROD_NAME) "innovus"}
catch {set ::env(PULSE_SCRIPT) "/etc/xrdp/pulse/default.pa"}
catch {set ::env(PWD) "/home/icd1/workspace/counter_design_45nm/physical_design"}
catch {set ::env(QT_X11_NO_MITSHM) "1"}
catch {set ::env(SHELL) "/bin/bash"}
catch {set ::env(SHLVL) "4"}
catch {set ::env(SPECTREROOT) "/home/icd1/cadence/installs/DDI251"}
catch {set ::env(SSH_AGENT_PID) "72598"}
catch {set ::env(SSH_ASKPASS) "/usr/libexec/openssh/gnome-ssh-askpass"}
catch {set ::env(SSH_AUTH_SOCK) "/tmp/ssh-iVc94kVVlKxW/agent.72462"}
catch {set ::env(TCLLIBPATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/lib/tcllib/1.18 "}
catch {set ::env(TCLLIB_LIBRARY) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/lib/tcllib/1.18"}
catch {set ::env(TCLTK_ROOT) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/tcltools/icd8.6.4/lib"}
catch {set ::env(TCL_LIBRARY) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/tcltools/icd8.6.4/lib/tcl8.6"}
catch {set ::env(TERM) "xterm-256color"}
catch {set ::env(TIX_LIBRARY) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/tcltools/icd8.6.4/lib/Tix8.4.3/library"}
catch {set ::env(TK_LIBRARY) "/home/icd1/cadence/installs/DDI251/INNOVUS251/share/tcltools/icd8.6.4/lib/tk8.6"}
catch {set ::env(TOOL_TCL_LIBPATH) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/tcltools/icd8.6.4/lib/64bit"}
catch {set ::env(UID) "1001"}
catch {set ::env(USER) "icd1"}
catch {set ::env(VTE_VERSION) "5204"}
catch {set ::env(W3264_ENV) "/home/icd1/.kshrc"}
catch {set ::env(W3264_PS_COMPAT_LIBDIR) "/home/icd1/cadence/installs/DDI251/INNOVUS251/tools.lnx86/lib/64bit/RHEL/RHEL8"}
catch {set ::env(W3264_STORED_HOSTID) "a8c00901"}
catch {set ::env(W3264_USER_LIBPATH) ""}
catch {set ::env(W3264_USER_PATH) "/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/cadence/installs/DDI251/INNOVUS251/bin:/home/icd1/cadence/installs/DDI251/GENUS251/tools.lnx86/bin/64bit:/home/icd1/cadence/installs/DDI251/GENUS251/tools.lnx86/bin:/home/icd1/cadence/installs/DDI251/GENUS251/bin:/home/icd1/cadence/installs/DDI251/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/.local/bin:/home/icd1/.opencode/bin:/home/icd1/.local/bin:/home/icd1/bin:/usr/share/Modules/bin:/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin"}
catch {set ::env(WINDOWID) "46137347"}
catch {set ::env(XDG_CONFIG_DIRS) "/etc/xdg"}
catch {set ::env(XDG_CURRENT_DESKTOP) "XFCE"}
catch {set ::env(XDG_DATA_DIRS) "/usr/local/share:/usr/share"}
catch {set ::env(XDG_MENU_PREFIX) "xfce-"}
catch {set ::env(XDG_RUNTIME_DIR) "/run/user/1001"}
catch {set ::env(XDG_SESSION_ID) "c6"}
catch {set ::env(XRDP_PULSE_SINK_SOCKET) "xrdp_chansrv_audio_out_socket_10"}
catch {set ::env(XRDP_PULSE_SOURCE_SOCKET) "xrdp_chansrv_audio_in_socket_10"}
catch {set ::env(XRDP_SESSION) "72439"}
catch {set ::env(XRDP_SOCKET_PATH) "/run/xrdp/1001"}
catch {set ::env(ps3264_osid) "almalinux"}
catch {set ::env(w3264_COMPAT_OSNAME) "8"}
catch {set ::env(w3264_COMPAT_OSVER) "RHEL8"}
catch {set ::env(w3264_osver) "8"}
catch {set ::env(which_declare) "declare -f"}
catch {set ::env(PROCINFO_HOST) "eda:37267"}
catch {set ::env(TK_TABLE_LIBRARY_FILE) "tkTable.tcl"}
catch {set ::env(TK_TABLE_LIBRARY) "EMBEDDED_RUNTIME"}
catch {set ::env(EDP_C_CODE) "1"}
catch {set ::env(ENABLE_MMMC2_VIEW_DEFINITION_GENERATION_IN_TEMPUS_CUI) "1"}
catch {set ::env(FE_MASTER_USER_ORIGINAL_TMPDIR) "/tmp"}
catch {set ::env(usefulSkewCCOpt) "1"}
catch {set ::env(_enable_mmmc_by_default_flow) "1"}
catch {set ::env(set_eso_pid_uuid) "0"}
catch {set ::env(PLUS_ATTRIBUTE_SOURCE) "DB"}
catch {set ::env(PLUS_PHYS_TCL) "/home/admin/cadence/installs/DDI251/INNOVUS251/tools.lnx86/../etc/synth/attr_def/plus_attr_defs.tcl /home/admin/cadence/installs/DDI251/INNOVUS251/tools.lnx86/../etc/synth/attr_def/plus_msg_defs.tcl"}
catch {set ::env(__QUANTUS_FIX_SLOW_NFS_MINIMAL__) "YES"}
catch {set ::env(__QUANTUS_LAYER_CLAMPING_UPDATED_DENSITY__) "false"}
catch {set ::env(EDP_MODE) "local"}
catch {set ::env(__HPY_MODELING_SMALL_SEG__) "false"}
catch {set ::env(TEMPDIR) "/tmp/innovus_temp_85141_4a5398aa-728e-47c7-9a83-d9d84f03a1e4_eda_icd1_KILzo9/iqrc_tmp_85141_42Nukm/.qrctemp/.xrctemp_0"}
catch {set ::env(__QRC_REMOVE_EROSION__) "YES"}
catch {if {[isLimitedAccessFeatureEnabled Intel_1280_PPA -silent] != 1} {setLimitedAccessFeature Intel_1280_PPA 1}}
catch {if {[isLimitedAccessFeatureEnabled invsEnableAI -silent] != 1} {setLimitedAccessFeature invsEnableAI 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_native -silent] != 1} {setLimitedAccessFeature ccopt_native 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_native_cts -silent] != 1} {setLimitedAccessFeature ccopt_native_cts 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_flexible_htree -silent] != 1} {setLimitedAccessFeature ccopt_flexible_htree 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_multithreading -silent] != 1} {setLimitedAccessFeature ccopt_multithreading 1}}
catch {if {[isLimitedAccessFeatureEnabled ccopt_opt_multithreading -silent] != 1} {setLimitedAccessFeature ccopt_opt_multithreading 1}}
catch {if {[isLimitedAccessFeatureEnabled cts_halo_mode_sum -silent] != 1} {setLimitedAccessFeature cts_halo_mode_sum 1}}
catch {if {[isLimitedAccessFeatureEnabled partition_feedthru_gui -silent] != 1} {setLimitedAccessFeature partition_feedthru_gui 1}}
catch {if {[isLimitedAccessFeatureEnabled invsHierModuleModel -silent] != 1} {setLimitedAccessFeature invsHierModuleModel 1}}
catch {::edp::setNodeId 4fb1ca82-bcb1-438c-bf34-c012f4c21f44_0/1}
startEdpSlave 0 eda 50553 32825 0 30
}
