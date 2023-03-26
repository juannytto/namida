import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:namida/class/folder.dart';
import 'package:namida/controller/folders_controller.dart';
import 'package:namida/controller/settings_controller.dart';
import 'package:namida/core/constants.dart';
import 'package:namida/core/icon_fonts/broken_icons.dart';
import 'package:namida/core/translations/strings.dart';
import 'package:namida/ui/widgets/custom_widgets.dart';
import 'package:namida/ui/widgets/library/folder_tile.dart';
import 'package:namida/ui/widgets/library/track_tile.dart';

class FoldersPage extends StatelessWidget {
  FoldersPage({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (SettingsController.inst.enableFoldersHierarchy.value) {
      Folders.inst.stepIn(Folders.inst.folderslist.firstWhere((element) => element.path.startsWith(SettingsController.inst.defaultFolderStartupLocation.value)));
    }

    return Obx(
      () => WillPopScope(
        onWillPop: () {
          if (!Folders.inst.isHome.value) {
            Folders.inst.stepOut();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: SettingsController.inst.enableFoldersHierarchy.value
            ? Column(
                children: [
                  ListTile(
                    leading: const Icon(Broken.folder_2),
                    title: Text(
                      Folders.inst.isHome.value ? Language.inst.HOME : Folders.inst.currentPath.value,
                      style: context.textTheme.displaySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () => Folders.inst.stepOut(),
                    trailing: Tooltip(
                      message: Language.inst.SET_AS_DEFAULT,
                      child: NamidaIconButton(
                        icon: SettingsController.inst.defaultFolderStartupLocation.value == Folders.inst.currentPath.value ? Broken.archive_tick : Broken.save_2,
                        onPressed: () =>
                            SettingsController.inst.save(defaultFolderStartupLocation: Folders.inst.isHome.value ? kStoragePaths.first : Folders.inst.currentPath.value),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CupertinoScrollbar(
                      controller: _scrollController,
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          if (Folders.inst.isHome.value) ...[
                            ...kStoragePaths
                                .toList()
                                .asMap()
                                .entries
                                .map(
                                  (e) => SliverToBoxAdapter(
                                    child: FolderTile(
                                      folder: Folder(
                                        1,
                                        e.value.split('/').last,
                                        e.value,
                                        Folders.inst.folderslist.where((element) => element.path.startsWith(e.value)).expand((entry) => entry.tracks).toList(),
                                      ),
                                    ),
                                  ),
                                )
                                .toList()
                          ],
                          if (!Folders.inst.isHome.value) ...[
                            SliverList(
                              delegate: SliverChildListDelegate(
                                Folders.inst.currentfolderslist.map((e) => FolderTile(folder: e)).toList(),
                              ),
                            ),
                            SliverAnimatedList(
                              key: UniqueKey(),
                              initialItemCount: Folders.inst.currentTracks.length,
                              itemBuilder: (context, i, animation) => TrackTile(
                                index: i,
                                track: Folders.inst.currentTracks.elementAt(i),
                                queue: Folders.inst.currentTracks.toList(),
                              ),
                            ),
                          ],
                          const SliverPadding(padding: EdgeInsets.only(bottom: kBottomPadding)),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  ListTile(
                    leading: const Icon(Broken.folder_2),
                    title: Text(
                      Folders.inst.currentPath.value == '' ? Language.inst.HOME : Folders.inst.currentPath.value,
                      style: context.textTheme.displaySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Folders.inst.stepOut();
                      Folders.inst.currentPath.value = '';
                    },
                  ),
                  Expanded(
                    child: CupertinoScrollbar(
                      controller: _scrollController,
                      child: ListView(
                        controller: _scrollController,
                        children: [
                          if (!Folders.inst.isInside.value)
                            ...Folders.inst.folderslist
                                .map((e) => FolderTile(
                                      folder: e,
                                      onTap: () {
                                        Folders.inst.currentTracks.assignAll(
                                            Folders.inst.folderslist.where((element) => element.folderName.startsWith(e.folderName)).expand((entry) => entry.tracks).toList());
                                        Folders.inst.isInside.value = true;
                                        Folders.inst.currentPath.value = e.folderName;
                                      },
                                    ))
                                .toList(),
                          ...Folders.inst.currentTracks
                              .asMap()
                              .entries
                              .map(
                                (e) => TrackTile(
                                  index: e.key,
                                  track: e.value,
                                  queue: Folders.inst.currentTracks.toList(),
                                ),
                              )
                              .toList(),
                          kBottomPaddingWidget,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
