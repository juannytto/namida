import 'package:flutter/material.dart';
import 'package:namida/class/track.dart';

///
String kAppDirectoryPath = '';
String kInternalAppDirectoryPath = '';
int kAudioFilesLength = 0;
Set<String> kDirectoriesPaths = {};
List<double> kDefaultWaveFormData = List<double>.generate(500, (index) => 0.02);

/// Main Color
Color kMainColor = const Color.fromARGB(160, 117, 128, 224);
Color kMainColorLight = const Color.fromARGB(255, 116, 126, 219);
Color kMainColorDark = const Color.fromARGB(255, 139, 149, 241);

/// Directories and files used by Namida
final String kSettingsFilePath = '$kAppDirectoryPath/NamidaSettings.gs';
final String kTracksFilePath = '$kAppDirectoryPath/tracks.json';
final String kPlaylistsFilePath = '$kAppDirectoryPath/playlists.json';
final String kArtworksDirPath = '$kAppDirectoryPath/Artworks/';
final String kArtworksCompDirPath = '$kAppDirectoryPath/ArtworksCompressed/';
final String kWaveformDirPath = '$kAppDirectoryPath/Waveforms/';
final String kVideosCachePath = '$kAppDirectoryPath/Videos/';
final String kVideosCacheTempPath = '$kAppDirectoryPath/Videos/Temp/';
final String kVideoPathsFilePath = '$kAppDirectoryPath/videoFilesPaths.txt';
final String kQueueFilePath = '$kAppDirectoryPath/queue.json';

/// Stock Library Tabs List
final List<String> kLibraryTabsStock = [
  'albums',
  'tracks',
  'artists',
  'genres',
  'playlists',
  'folders',
];

/// Stock Video Qualities List
final List<String> kStockVideoQualities = [
  '144p',
  '240p',
  '360p',
  '480p',
  '720p',
  '1080p',
  '2k',
  '4k',
  '8k',
];

/// Default values available for setting the Date Time Format.
const kDefaultDateTimeStrings = {
  'yyyyMMdd': '20220413',
  'dd/MM/yyyy': '13/04/2022',
  'MM/dd/yyyy': '04/13/2022',
  'yyyy/MM/dd': '2022/04/13',
  'yyyy/dd/MM': '2022/13/04',
  'dd-MM-yyyy': '13-04-2022',
  'MM-dd-yyyy': '04-13-2022',
  'MMMM dd, yyyy': 'April 13, 2022',
  'MMM dd, yyyy': 'Apr 13, 2022',
  '[dd | MM]': '[13 | 04]',
  '[dd.MM.yyyy]': '[13.04.2022]',
};

/// Extensions used to filter files
const List<String> kFileExtensions = [
  '.aac',
  '.ac3',
  '.aiff',
  '.amr',
  '.ape',
  '.au',
  '.dts',
  '.flac',
  '.m4a',
  '.m4b',
  '.m4p',
  '.mid',
  '.mp3',
  '.ogg',
  '.opus',
  '.ra',
  '.tak',
  '.wav',
  '.wma',
];
const List<String> kVideoFilesExtensions = [
  'mp4',
  'mkv',
  'avi',
  'wmv',
  'flv',
  'mov',
  '3gp',
  'ogv',
  'webm',
  'mpg',
  'mpeg',
  'm4v',
  'ts',
  'vob',
  'asf',
  'rm',
  'swf',
  'f4v',
  'divx',
  'm2ts',
  'mts',
  'mpv',
  'mp2',
  'mpe',
  'mpa',
  'mxf',
  'm2v',
  'mpeg1',
  'mpeg2',
  'mpeg4'
];
final kDummyTrack = Track(
  '',
  [''],
  '',
  '',
  [''],
  '',
  0,
  0,
  0,
  0,
  0,
  0,
  '0',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  0,
  0,
  '',
  '',
  0,
  '',
  '',
  '',
  '',
);