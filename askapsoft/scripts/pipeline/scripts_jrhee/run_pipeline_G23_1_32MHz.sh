#!/usr/bin/env bash
#
#==============================================================================#
# A modifedy-version of defaultConfig.sh working with 0.23.3 version
# modified by J.Rhee Sep 2018 for GAMA23_1 data processing on GALAXY
#
# ASKAP-12 observations (1248.5 - 1440.5 MHz)
# 09 Sep 2017: cal = 4214, science = 4216, footprint = A/B square_6x6, 8.7h, 192 MHz
# 11 Sep 2017: cal = 4236, science = 4240, footprint = A/B square_6x6, 9.4h, 192 MHz
#
# ASKAP-16 & band 1 observation (960.5 - 1200.5 MHz)
# 07 Jan 2018: cal = 4943, science = 4944, footprint = A/B square_6x6, 11.2h, 240 MHz
#
# ASKAP-16 & band 1 observation (792.5 - 1032.5 MHz)
# 15 Jan 2018: cal = 4999, science = 5000, footprint = A/B square_6x6, 11.2h, 240 MHz
#                 or 5001
#
# ASKAP-16 & band 1 observation (816.5 - 1056.5 MHz)
# 18 Mar 2018: cal = 5231, science = 5232, footprint = A/B square_6x6, 11.2h, 240 MHz
#                 or 5233
#
# To run the script, type the following in output folder
#    > processASKAP.sh -c run_pipeline.sh
#==============================================================================#


########################################
# SLURM CONTROLS
# Whether to submit jobs to the queue
SUBMIT_JOBS=true

# Account to use for the jobs. If left blank, the user's default
# askaprt (rt = ‘real time’) for operational processing priority in the queue
#ACCOUNT=askaprt
#ACCOUNT=ja3
#CLUSTER=magnus

# Times for individual slurm jobs
# Set job time for spectral imaging
JOB_TIME_DEFAULT="12:00:00"

# Enable email notifications
# No notifications sent if blank
EMAIL=jonghwan.rhee@icrar.org

# Type of notification
# BEGIN, END, FAIL, REQUEUE, ALL, TIME_LIMIT, TIME_LIMIT_90, TIME_LIMIT_80, and TIME_LIMIT_50
EMAIL_TYPE=FAIL

# User can select a particular version of the askapsoft module
ASKAPSOFT_VERSION="0.24b"
#ASKAPSOFT_VERSION="0.23.2"

# Project ID (Wallaby: AS035, Dingo: AS036)
PROJECT_ID="AS036"


########################################
# The output directory for images, MS, tables, etc
OUTPUT=SB4216

# If true, copy with distributed copy tool dcp. Else use cp
USE_DCP_TO_COPY_MS=true

# If true, turn on profiling for the imaging jobs (only cimager and imager have this option) new in 0.23.0
USE_PROFILING=true


########################################
# Input Scheduling Blocks (SBs)
# Location of the SBs
#DIR_SB=/astro/askaprt/askapops/askap-scheduling-blocks
DIR_SB=/group/askap/jrhee/Dingo

# SBID for the calibration observation
SB_1934=4214
#SB_1934=4236
#SB_1934=4943
#SB_1934=4999 or 5001
#SB_1934=5231 or 5233

# SBID for the science observation
SB_SCIENCE=4216
#SB_SCIENCE=4240
#SB_SCIENCE=4944
#SB_SCIENCE=5000
#SB_SCIENCE=5232

# Set to not true if you know the schedblock & footprint services are offline
#USE_CLI=false

# Remove interim MSs when running local merging (new in 0.22.0)
PURGE_INTERIM_MS_SCI=true
PURGE_INTERIM_MS_1934=true


########################################
# BEAM SELECTION
# Range of beam values to process (starts counting at 0)
BEAM_MIN=0
BEAM_MAX=35
#BEAMLIST="10-12,20,27-30"

# Footprint Rotation
FOOTPRINT_PA_REFERENCE=45


########################################
# Image output type
# Default for IMAGETYPES is "fits" from 0.21.0
IMAGETYPE_CONT=fits
IMAGETYPE_CONTCUBE=fits
IMAGETYPE_SPECTRAL=fits


#==============================================================================#
# CALIBRATOR CONTROL SWITCHES

# Whether to do the bandpass calibration (master switch)
DO_1934_CAL=true

# Split calibrator out by beam/scan
DO_SPLIT_1934=true

# Flag the calibrator
DO_FLAG_1934=true

# Find the bandpass calibration table
DO_FIND_BANDPASS=true


#==============================================================================#
# SCIENCE FIELD CONTROL SWITCHES

# Whether to process the science field observation (master switch)
DO_SCIENCE_FIELD=true

# Split science observation by beam
DO_SPLIT_SCIENCE=true

# Flag the science observation
DO_FLAG_SCIENCE=true

# Apply the bandpass calibration table
DO_APPLY_BANDPASS=true

# Average channels to continuum resolution (1MHz or others)
DO_AVERAGE_CHANNELS=true

# Make a continuum image
DO_CONT_IMAGING=true

# Do self-calibration loops
DO_SELFCAL=true

# Apply self-calibration solution
DO_APPLY_CAL_CONT=true

# Run the continuum validation script following source finding
DO_CONTINUUM_VALIDATION=true

# Make continuum cubes
DO_CONTCUBE_IMAGING=false

# Copy the spectral-line data (for a subset of the data) to a new MS
DO_COPY_SL=false

# Apply the gains calibration from the continuum self-cal
DO_APPLY_CAL_SL=true

# Subtract a model of the continuum
DO_CONT_SUB_SL=true

# Make spectral-line image cubes
DO_SPECTRAL_IMAGING=true

# Run image-based continuum subtraction on created spectral cube
DO_SPECTRAL_IMSUB=true

# Form a mosaic of multiple beams
DO_MOSAIC=true

# Whether to mosaic the different fields together
# (for when there is more than one in the MS).
DO_MOSAIC_FIELDS=true

# Do source-finding with Selavy on the continuum images
DO_SOURCE_FINDING_CONT=false

# Do source-finding with Selavy on the spectral data cubes
DO_SOURCE_FINDING_SPEC=false

# Do source-finding on the individual beam images
DO_SOURCE_FINDING_BEAMWISE=true

# Use the new (alt) imager for continuum and spectral imaging.
# in 0.19.6 version, default imager is the new imager
DO_ALT_IMAGER=true

# Use the new imager rather than "simager" for continuum imaging
# if not specified, default to the value of DO_ALT_IMAGER
DO_ALT_IMAGER_CONT=true

# Use the new imager rather than "simager" for spectral line cube
# (former does barycentric correction)
# if not specified, default to the value of DO_ALT_IMAGER
DO_ALT_IMAGER_SPECTRAL=true


#==============================================================================#
# POST-PROCESSING CONTROL SWITCHES

# Convert CASA images to FITS format
DO_CONVERT_TO_FITS=true

# Make PNG thumbnail images of the 2D FITS images (need to make FITS images first)
# This is set true for default from 0.22.0
DO_MAKE_THUMBNAILS=true

# Run a cube validation script (new in 0.22.0)
DO_VALIDATION_SCIENCE=true

# Stage data for ingest into CASDA
DO_STAGE_FOR_CASDA=false


#==============================================================================#
# PARAMETER SETTINGS

# Channel range to use for the calibrator and science datasets
#CHAN_RANGE_1934=7561-9288
#CHAN_RANGE_SCIENCE=7561-9288
#CHAN_RANGE_1934=1-9288
#CHAN_RANGE_SCIENCE=1-9288
#CHAN_RANGE_1934=1-10368
#CHAN_RANGE_SCIENCE=1-10368
#CHAN_RANGE_1934=8425-9288
#CHAN_RANGE_SCIENCE=8425-9288
#CHAN_RANGE_1934=7561-8424
#CHAN_RANGE_SCIENCE=7561-8424
CHAN_RANGE_1934=4672-6399
CHAN_RANGE_SCIENCE=4672-6399

# Number of channels in the tile for the new MS we create through merging or splitting (new in 0.22.0)
TILE_NCHAN_SCIENCE=54
TILE_NCHAN_1934=54

# Number of channels to be averaged to create continuum measurement set
NUM_CHAN_TO_AVERAGE=54

# Base names for the MSs to be split
MS_BASE_1934=CAL_SB${SB_1934}_%b.ms
MS_BASE_SCIENCE=SCI_SB${SB_SCIENCE}_%b.ms


########################################
# FLAGGING

# Baselines or antennas to flag for 1934 and science
#ANTENNA_FLAG_1934="ak05"
#ANTENNA_FLAG_1934="ak02;ak14;ak04&ak05;ak04&ak10;ak05&ak10"
#ANTENNA_FLAG_1934="ak10;ak14;ak02&ak04;ak02&ak05;ak04&ak05"
#ANTENNA_FLAG_1934="ak02&ak04;ak02&ak05;ak02&ak10;ak04&ak05;ak04&ak10;ak05&ak10"
#ANTENNA_FLAG_1934="ak14;ak02&ak04;ak02&ak05;ak02&ak10;ak04&ak05;ak04&ak10;ak05&ak10"
#ANTENNA_FLAG_1934="ak16;ak30"
ANTENNA_FLAG_1934=""
#ANTENNA_FLAG_SCIENCE=""
#ANTENNA_FLAG_SCIENCE="ak05"
#ANTENNA_FLAG_SCIENCE="ak14"
#ANTENNA_FLAG_SCIENCE="ak02;ak14"
#ANTENNA_FLAG_SCIENCE="ak10;ak14"
ANTENNA_FLAG_SCIENCE="ak19"
#ANTENNA_FLAG_SCIENCE=""

# Channel range(s) to flag in the 1934 and science data
CHANNEL_FLAG_1934=""
CHANNEL_FLAG_SCIENCE="0:486"

# Time range(s) to flag in the 1934 and the science data (new in 0.20.0)
TIME_FLAG_1934=""
TIME_FLAG_SCIENCE=""

# Whether to flag autocorrelations for the 1934 and science data
FLAG_AUTOCORRELATION_1934=true
FLAG_AUTOCORRELATION_SCIENCE=true

####################
# Whether to do dynamic flagging
FLAG_DO_DYNAMIC_AMPLITUDE_1934=true
FLAG_DO_DYNAMIC_AMPLITUDE_SCIENCE=true

# Dynamic threshold applied to amplitudes [sigma]
FLAG_THRESHOLD_DYNAMIC_1934=4.0
FLAG_THRESHOLD_DYNAMIC_SCIENCE=4.0

# Whether to apply a dynamic threshold to integrated spectra
FLAG_DYNAMIC_1934_INTEGRATE_SPECTRA=true
FLAG_DYNAMIC_INTEGRATE_SPECTRA=true

# Dynamic threshold applied to amplitudes in integrated spectra mode  [sigma]
FLAG_THRESHOLD_DYNAMIC_1934_SPECTRA=4.0
FLAG_THRESHOLD_DYNAMIC_SCIENCE_SPECTRA=4.0

# Whether to apply a dynamic threshold to integrated times
FLAG_DYNAMIC_1934_INTEGRATE_TIMES=true
FLAG_DYNAMIC_INTEGRATE_TIMES=true

# Dynamic threshold applied to amplitudes in integrated times mode [sigma]
FLAG_THRESHOLD_DYNAMIC_1934_TIMES=4.0
FLAG_THRESHOLD_DYNAMIC_SCIENCE_TIMES=4.0

####################
# Whether to apply a flat amplitude cut
FLAG_DO_FLAT_AMPLITUDE_1934=false
FLAG_DO_FLAT_AMPLITUDE_SCIENCE=false

# Flat amplitude threshold applied
# for 1934 [hardware units - before calibration]
# for science [calibrated flux units]
FLAG_THRESHOLD_AMPLITUDE_1934=0.2
FLAG_THRESHOLD_AMPLITUDE_SCIENCE=10.

# Minimum amplitude threshold applied
# for 1934 [hardware units - before calibration]
# for science [calibrated flux units]
FLAG_THRESHOLD_AMPLITUDE_1934_LOW=""
FLAG_THRESHOLD_AMPLITUDE_SCIENCE_LOW=""

####################
# Whether to do Stokes-V flagging
FLAG_DO_STOKESV_1934=true
FLAG_DO_STOKESV_SCIENCE=true

# Whether to use robust statistics for Stokes-V flagging
FLAG_USE_ROBUST_STATS_STOKESV_1934=true
FLAG_USE_ROBUST_STATS_STOKESV_SCIENCE=true

# Threshold applied to amplitudes in Stokes-V flagging [sigma]
FLAG_THRESHOLD_STOKESV_1934=4.0
FLAG_THRESHOLD_STOKESV_SCIENCE=4.0

# Whether to apply a Stokes-V threshold to integrated spectra
FLAG_STOKESV_1934_INTEGRATE_SPECTRA=true
FLAG_STOKESV_INTEGRATE_SPECTRA=true

# Threshold applied to amplitudes in integrated spectra mode of
# Stokes-V flagging  [sigma]
FLAG_THRESHOLD_STOKESV_1934_SPECTRA=4.0
FLAG_THRESHOLD_STOKESV_SCIENCE_SPECTRA=4.0

# Whether to apply a Stokes-V threshold to integrated times
FLAG_STOKESV_1934_INTEGRATE_TIMES=true
FLAG_STOKESV_INTEGRATE_TIMES=true

# Threshold applied to amplitudes in integrated times mode of Stokes-V
# flagging [sigma]
FLAG_THRESHOLD_STOKESV_1934_TIMES=4.0
FLAG_THRESHOLD_STOKESV_SCIENCE_TIMES=4.0

####################
# Flag averaged data
# Run flagging after averaging, as well as after bandpass application
FLAG_AFTER_AVERAGING=true

# Channel range(s) to flag in the averaged science data
CHANNEL_FLAG_SCIENCE_AV=""

# Time range(s) to flag in the averaged science data (new in 0.20.0)
TIME_FLAG_SCIENCE_AV=""

### Whether to do dynamic flagging on the averaged data
FLAG_DO_DYNAMIC_AMPLITUDE_SCIENCE_AV=true

# Dynamic threshold applied to amplitudes of averaged data [sigma]
FLAG_THRESHOLD_DYNAMIC_SCIENCE_AV=4.0

# Whether to apply a dynamic threshold to integrated spectra on averaged data
FLAG_DYNAMIC_INTEGRATE_SPECTRA_AV=true

# Dynamic threshold applied to amplitudes in integrated spectra mode  [sigma]
FLAG_THRESHOLD_DYNAMIC_SCIENCE_SPECTRA_AV=4.0

# Whether to apply a dynamic threshold to integrated times on averaged data
FLAG_DYNAMIC_INTEGRATE_TIMES_AV=true

# Dynamic threshold applied to amplitudes in integrated times mode [sigma]
FLAG_THRESHOLD_DYNAMIC_SCIENCE_TIMES_AV=4.0

### Whether to apply a flat amplitude cut to the averaged data
FLAG_DO_FLAT_AMPLITUDE_SCIENCE_AV=false

# Flat amplitude threshold applied to the averaged data [calibrated flux units]
FLAG_THRESHOLD_AMPLITUDE_SCIENCE_AV=10.

# Minimum amplitude threshold applied to the averaged data [calibrated flux units]
FLAG_THRESHOLD_AMPLITUDE_SCIENCE_LOW_AV=""

### Whether to do Stokes-V flagging on the averaged data
FLAG_DO_STOKESV_SCIENCE_AV=true

# Whether to use robust statistics for Stokes-V flagging
FLAG_USE_ROBUST_STATS_STOKESV_SCIENCE_AV=true

# Threshold applied to amplitudes of averaged data for Stokes-V
# flagging [sigma]
FLAG_THRESHOLD_STOKESV_SCIENCE_AV=4.0

# Whether to apply a Stokes-V threshold to integrated spectra on averaged data
FLAG_STOKESV_INTEGRATE_SPECTRA_AV=true

# Threshold applied to amplitudes in integrated spectra mode for
# Stokes-V flagging  [sigma]
FLAG_THRESHOLD_STOKESV_SCIENCE_SPECTRA_AV=4.0

# Whether to apply a Stokes-V threshold to integrated times on averaged data
FLAG_STOKESV_INTEGRATE_TIMES_AV=true

# Threshold applied to amplitudes in integrated times mode for
# Stokes-V flagging [sigma]
FLAG_THRESHOLD_STOKESV_SCIENCE_TIMES_AV=4.0

######################
# AOflagger options
# New in 0.21.0

# Global switch, plus switches for individual flagging tasks. Setting
# the global switch will override the individual values
FLAG_WITH_AOFLAGGER=""
FLAG_1934_WITH_AOFLAGGER=false
FLAG_SCIENCE_WITH_AOFLAGGER=false
FLAG_SCIENCE_AV_WITH_AOFLAGGER=false

# Strategy files. Setting the global one overrides the individual
# values.
AOFLAGGER_STRATEGY=""
AOFLAGGER_STRATEGY_1934=""
AOFLAGGER_STRATEGY_SCIENCE=""
AOFLAGGER_STRATEGY_SCIENCE_AV=""

# Verbose output (-v option for aoflagger) - global parameter
AOFLAGGER_VERBOSE=true

# Read mode for AOflagger - either "auto", "direct", "indirect",
# "memory". These trigger the following respective command-line
# options: -auto-read-mode, -direct-read, -indirect-read, -memory-read
AOFLAGGER_READ_MODE="auto"

# Allow use of uvw values
AOFLAGGER_UVW=false


########################################
# BANDPASS

# Number of cycles used in cbpcalibrator (or 40)
NCYCLES_BANDPASS_CAL=50

# Number of CPUs (cores) used for the cbpcalibrator job (or 200)
NUM_CPUS_CBPCAL=216

# Limit the data selection for bandpass solving to a minimum UV distance [m]
BANDPASS_MINUV=200

# Reference antenna to be used in the cbpcalibrator task (new in 0.19.6)
BANDPASS_REFANTENNA=1

########################################
# Smoothing of bandpass
# Whether to smooth the bandpass
DO_BANDPASS_SMOOTH=true

# Which method to use - either "plot_caltable" or "smooth_bandpass" (new in 0.21.0)
BANDPASS_SMOOTH_TOOL="plot_caltable"
#BANDPASS_SMOOTH_TOOL="smooth_bandpass"

####################
# The following are parameters for plot_caltable
# Whether to run plot_caltable.py to produce plots
DO_BANDPASS_PLOT=true
# If true, smooth the amplitudes. If false, smooth real & imaginary
BANDPASS_SMOOTH_AMP=true
# If true, only smooth outlier points
BANDPASS_SMOOTH_OUTLIER=true
# polynomial order (if >= 0) or window size (if <0) to use when smoothing bandpass
BANDPASS_SMOOTH_FIT=1
# The threshold level for fitting bandpass
BANDPASS_SMOOTH_THRESHOLD=1.0

####################
# The following are parameters for smooth_bandpass
# The polynomial order for the fit
BANDPASS_SMOOTH_POLY_ORDER=3
# The harmonic order for the fit
BANDPASS_SMOOTH_HARM_ORDER=6
# The number of windows to divide the spectrum into for the moving fit
BANDPASS_SMOOTH_N_WIN=4
# The width (in channels) of the Gaussian Taper function to remove
# high-frequency components
BANDPASS_SMOOTH_N_TAPER=""
# The number of iterations for Fourier-interpolation across flagged
# points
BANDPASS_SMOOTH_N_ITER=100

####################
# Apply bandpass to the calibrator itself (new in 0.19.6)
# Whether to apply the bandpass solution to the 1934 dataset itself
DO_APPLY_BANDPASS_1934=false

# If true, keep the raw bandpass datasets separate to the calibrated
# versions
KEEP_RAW_1934_DATA=true


########################################
# CONTINUUM IMAGING

# Base name for the images
IMAGE_BASE_CONT=i.G23_1.cont.SB${SB_SCIENCE}

# Number of CPUs to use on each core in the continuum imaging
CPUS_PER_CORE_CONT_IMAGING=20

# Number of pixels on the side of the images to be created
#NUM_PIXELS_CONT=3200
NUM_PIXELS_CONT=2048

# Size of the pixels in arcsec
#CELLSIZE_CONT=4
CELLSIZE_CONT=6

# Number of Taylor terms to create in MFS imaging
NUM_TAYLOR_TERMS=2

# Make the images at the centres of the beams, rather than the same
# image centre for each beam
IMAGE_AT_BEAM_CENTRES=true

####################
# Gridding parameters for continuum imaging
# default for w-snapshot imaging is false from 0.22.0
GRIDDER_SNAPSHOT_IMAGING=false

####################
# Cleaning parameters for continuum imaging
SOLVER=Clean
CLEAN_ALGORITHM=BasisfunctionMFS
CLEAN_MINORCYCLE_NITER=4000
CLEAN_GAIN=0.1
CLEAN_PSFWIDTH=256
#CLEAN_PSFWIDTH=1600
CLEAN_SCALES="[0]"
#CLEAN_SCALES="[0,3,10,30]"

# Minor cycle threshold for the Cleaning
CLEAN_THRESHOLD_MINORCYCLE="[40%, 1.8mJy, 0.08mJy]"
#CLEAN_THRESHOLD_MINORCYCLE="[40%, 1.8mJy]"

# If true, this will write out intermediate images at the end of each
# major cycle
CLEAN_WRITE_AT_MAJOR_CYCLE=false

# solution type for continuum cleaning - either MAXCHISQ or MAXBASE
CLEAN_SOLUTIONTYPE="MAXCHISQ"

# Array-capable self-calibration parameters
#   These parameters can be given as either a single value (eg. "300")
#   which is replicated for all self-cal loops, or as an array
#   (eg. "[1800,900,300]"), allowing a different value for each loop.
# If no self-calibration is used, we just use the first element
#
# Number of major cycles to do
#CLEAN_NUM_MAJORCYCLES="[1,8,10]"
CLEAN_NUM_MAJORCYCLES="[5,10,10]"

# The maximum residual to stop the major-cycle deconvolution (if not
# reached, or negative, CLEAN_NUM_MAJORCYCLES cycles are used)
#CLEAN_THRESHOLD_MAJORCYCLE="[10mJy,4mJy,2mJy]"
CLEAN_THRESHOLD_MAJORCYCLE="0.08mJy"

####################
# Parameters for preconditioning (A.K.A. weighting)
PRECONDITIONER_LIST="[Wiener]"
PRECONDITIONER_GAUSS_TAPER="[10arcsec, 10arcsec, 0deg]"
#PRECONDITIONER_GAUSS_TAPER=""
PRECONDITIONER_WIENER_ROBUSTNESS=-0.5
#PRECONDITIONER_WIENER_ROBUSTNESS=0.5
PRECONDITIONER_WIENER_TAPER=""

# Parameters for preconditioning for the restore solver alone
RESTORE_PRECONDITIONER_LIST=""
RESTORE_PRECONDITIONER_GAUSS_TAPER="[10arcsec, 10arcsec, 0deg]"
#RESTORE_PRECONDITIONER_GAUSS_TAPER=""
RESTORE_PRECONDITIONER_WIENER_ROBUSTNESS=-2
#RESTORE_PRECONDITIONER_WIENER_ROBUSTNESS=0.5
RESTORE_PRECONDITIONER_WIENER_TAPER=""


########################################
# SELF-CALIBRATION PARAMETERS

# Method to present self-cal model: via a model image ("Cmodel") or
# via a components parset ("Components") or using the
# continuum-imaging clean model ("CleanModel")
SELFCAL_METHOD="Cmodel"
#SELFCAL_METHOD="Components"
#SELFCAL_METHOD="CleanModel"

# Reference antenna to use in self-calibration. Should be antenna
# number, 0 - nAnt-1 that matches antenna numbering in MS
SELFCAL_REF_ANTENNA=""

# Number of loops of self-calibration
SELFCAL_NUM_LOOPS=2

# Time interval over which to solve for self-calibration (seconds)
#SELFCAL_INTERVAL="[3600,1200,900]"
#SELFCAL_INTERVAL="[57600,600,180]"
SELFCAL_INTERVAL="[1800,1800,200]"

# Option to pass to the "Ccalibrator.normalisegains" parameter,
# indicating we want to approximate phase-only self-cal
SELFCAL_NORMALISE_GAINS="[true,true,true]"

# Should we make full-field mosaics of each loop iteration?
MOSAIC_SELFCAL_LOOPS=false

# Limit the data selection for imaging to a minimum UV distance [m]
CIMAGER_MINUV=0

# Limit the data selection for calibration to a minimum UV distance [m]
CCALIBRATOR_MINUV=0

####################
# Selavy parameters for self-calibration
# SNR threshold for detection with selavy in determining selfcal sources
SELFCAL_SELAVY_THRESHOLD=8

# Division of image for source-finding in selfcal
SELFCAL_SELAVY_NSUBX=6
SELFCAL_SELAVY_NSUBY=3

####################
# Shift position offsets - precomputed, and added to position in final
# self-cal selavy catalogue
DO_POSITION_OFFSET=false

# Position offsets in arcsec
RA_POSITION_OFFSET=0
DEC_POSITION_OFFSET=0


########################################
# CONTINUUM VALIDATION

# Run the validation for individual beam images
VALIDATE_BEAM_IMAGES=true

# Location to copy validation directories to
#VALIDATION_ARCHIVE_DIR="/group/askap/jrhee/ValidationReportsArchive"
VALIDATION_ARCHIVE_DIR="/group/askap/ValidationReportsArchive"

# Whether to remove the .csv files when copying the validation
# directories
REMOVE_VALIDATION_CSV=true


########################################
# CONTINUUM SUBTRACTION (UV domain)

# Continuum subtraction method
# Cmodel (default): use a model image constructed by Cmodel
# Components: uses the Selavy catalogue directly by in the form of components
# CleanModel: uses the clean model from the continuum imaging
CONTSUB_METHOD="Cmodel"
#CONTSUB_METHOD="Components"
#CONTSUB_METHOD="CleanModel"

# Division of image for source-finding in continuum-subtraction
CONTSUB_SELAVY_NSUBX=6
CONTSUB_SELAVY_NSUBY=3

# Detection threshold for Selavy in building continuum model
CONTSUB_SELAVY_THRESHOLD=6


########################################
# Spectral-line imaging parameters

# Base name for the spectral cubes
IMAGE_BASE_SPECTRAL=i.G23_1.cube.SB${SB_SCIENCE}

# Spatial size of the cubes (in pixels)
#NUM_PIXELS_SPECTRAL=1536
NUM_PIXELS_SPECTRAL=1024

# Angular size of pixel, in arcsec
#CELLSIZE_SPECTRAL=4
CELLSIZE_SPECTRAL=6

# Rest frequency for the cube ('HI'=1420.405751786 MHz)
REST_FREQUENCY_SPECTRAL=HI

# Whether to convert the frequency channels to the Barycentre frame
DO_BARY=true

# Number of subcubes to make when imaging with new imager (1 = no subcubes)
NUM_SPECTRAL_WRITERS=8

####################
# MPI Parameters
# the spectral line imager needs its own otherwise we lose some flexibility
#NCHAN_PER_CORE_SL=9 (default)
NCHAN_PER_CORE_SL=4
# Number of processors allocated to the spectral-line imaging
NUM_CPUS_SPECIMG_SCI=200
# Number of processors per node for the spectral-line imaging
CPUS_PER_CORE_SPEC_IMAGING=20
# Number of processors for spectral-line mosaicking.
# Leave blank to scale according to number of channels per core
NUM_CPUS_SPECTRAL_LINMOS=""
# Number of channels handled by each core in the spectral-line
# mosaicking. Will determine total number of cores based on number of
# channels to be mosaicked.
#NCHAN_PER_CORE_SPECTRAL_LINMOS=8 (default)
NCHAN_PER_CORE_SPECTRAL_LINMOS=4

####################
# Gridding parameters for spectral-line imaging
GRIDDER_SPECTRAL_SNAPSHOT_IMAGING=true

####################
# Cleaning parameters sepctral-line imaging
SOLVER_SPECTRAL=Clean
CLEAN_SPECTRAL_ALGORITHM=BasisfunctionMFS
CLEAN_SPECTRAL_MINORCYCLE_NITER=2000
CLEAN_SPECTRAL_GAIN=0.1
#CLEAN_SPECTRAL_PSFWIDTH=256
CLEAN_SPECTRAL_PSFWIDTH=512
CLEAN_SPECTRAL_SCALES="[0,3,10]"
CLEAN_SPECTRAL_THRESHOLD_MINORCYCLE="[50%, 20mJy]"
#CLEAN_SPECTRAL_THRESHOLD_MINORCYCLE="[50%, 30mJy, 3.5mJy]"

# Solution type for spectral cleaning - either MAXCHISQ or MAXBASE
# new in 0.22.0
#CLEAN_SPECTRAL_SOLUTIONTYPE="MAXCHISQ"
CLEAN_SPECTRAL_SOLUTIONTYPE="MAXBASE"

# Threshold for major cycles
CLEAN_SPECTRAL_THRESHOLD_MAJORCYCLE=18mJy
#CLEAN_SPECTRAL_THRESHOLD_MAJORCYCLE=20mJy

# Number of major cycles to do in spectral imaging
CLEAN_SPECTRAL_NUM_MAJORCYCLES=5
#CLEAN_SPECTRAL_NUM_MAJORCYCLES=10

####################
# Parameters for preconditioning (A.K.A. weighting) - allow these to
# be different to the continuum case
PRECONDITIONER_LIST_SPECTRAL="[Wiener, GaussianTaper]"
#PRECONDITIONER_SPECTRAL_GAUSS_TAPER="[20arcsec, 20arcsec, 0deg]"
PRECONDITIONER_SPECTRAL_GAUSS_TAPER="[18arcsec, 18arcsec, 0deg]"
PRECONDITIONER_SPECTRAL_WIENER_ROBUSTNESS=0.5
PRECONDITIONER_SPECTRAL_WIENER_TAPER=""


########################################
# IMAGE-BASED CONTINUUM SUBTRACTION (2 options)

# Which ACES script to use - only "robust_contsub.py" or
# "contsub_im.py" accepted
SPECTRAL_IMSUB_SCRIPT=robust_contsub.py
#SPECTRAL_IMSUB_SCRIPT=contsub_im.py

# Defaults that apply to both scripts
# Verbose output
SPECTRAL_IMSUB_VERBOSE=true

####################
# Defaults for the robust_contsub.py script
# Threshold [sigma] to mask outliers prior to fitting ('threshold' parameter)
SPECTRAL_IMSUB_THRESHOLD=1.0
# Order of polynomial to fit ('fit_order' parameter)
SPECTRAL_IMSUB_FIT_ORDER=1
# Only use every nth channel ('n_every' parameter)
SPECTRAL_IMSUB_CHAN_SAMPLING=1
# Log every nth channel ('log_every' parameter)
SPECTRAL_IMSUB_LOG_SAMPLING=1

####################
# Defaults for the contsub_im.py script
# Half-width of the Savitzky-Golay filter [channels]
SPECTRAL_IMSUB_SG_FILTERWIDTH=200
# Bin width for binning spectrum before continuum subtraction
SPECTRAL_IMSUB_SG_BINWIDTH=4


########################################
# Mosaicking continuum images:
# The footprint name
BEAM_FOOTPRINT_NAME="square_6x6"

# The position angle of the beam footprint
BEAM_FOOTPRINT_PA=0

# The pitch of the beams in the footprint
BEAM_PITCH=0.9

# This is over-ridden with BEAM_PITCH.
FREQ_BAND_NUMBER=2

# The argument used for linmos.weighttype when mosaicking all beams of
# a given footprint. Can be either "Combined" or "FromPrimaryBeamModel".
# New in 0.19.6
LINMOS_SINGLE_FIELD_WEIGHTTYPE="Combined"
