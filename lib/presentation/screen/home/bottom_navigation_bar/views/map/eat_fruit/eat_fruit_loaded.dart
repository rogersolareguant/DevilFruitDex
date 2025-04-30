import 'package:audioplayers/audioplayers.dart';
import 'package:devilfruitdex/domain/model/devil_fruit.dart';
import 'package:devilfruitdex/presentation/screen/home/cubit/devil_fruit_cubit.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/devil_fruit_detail_id.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/go_back_button.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/app_bar_widgets/title_detail_screen.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/devil_fruit_type.dart';
import 'package:devilfruitdex/presentation/screen/home/detail/widgets/detail_widgets/image_positioned_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class EatFruitLoaded extends StatefulWidget {
  final DevilFruit devilFruit;

  const EatFruitLoaded({
    super.key,
    required this.devilFruit,
  });

  @override
  State<EatFruitLoaded> createState() => _EatFruitLoadedState();
}

class _EatFruitLoadedState extends State<EatFruitLoaded> {
    late final AudioPlayer _player;
    bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
  }

  Future<void> _playEatingSound() async {
    await _player.setVolume(1.0);
    await _player.play(AssetSource('sounds/eating-sound-effect.mp3'));
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevilFruitCubit, DevilFruitState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(children: [
            AppBar(
                leading: const GoBackButton(),
                title: TitleDetailScreen(devilFruit: widget.devilFruit),
                actions: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: DevilFruitDetailId(devilFruit: widget.devilFruit)),
                ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
              child: Container(
                  alignment: Alignment.topCenter,
                  child: FilledButton(
                      onPressed: () {
                        if (!isPlaying) {
                          isPlaying = true;
                        _playEatingSound();
                        context.read<DevilFruitCubit>().updateEating(true);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Theme.of(context)
                                  .colorScheme
                                  .onPrimaryFixedVariant)),
                      child: Text(AppLocalizations.of(context)!.eat,
                          style: Theme.of(context).textTheme.bodyLarge))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 220, 0, 0),
              child: Container(
                alignment: Alignment.center,
                height: 1000,
                width: 410,
                color: Theme.of(context).dialogBackgroundColor,
                child: SafeArea(
                  child: ListView(
                    children: [
                      Stack(alignment: Alignment.center, children: [
                        
                        ImagePositionedEat(devilFruit: widget.devilFruit),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                          child: Visibility(
                            visible: state.isEating,
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).dialogBackgroundColor,
                                )),
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.fromLTRB(100, 70, 0, 0),
                          child: Visibility(
                            visible: state.isEating,
                            child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).dialogBackgroundColor,
                                )),
                          ),
                        ),
                        if (state.isConfetti)
                          Center(
                            child: Lottie.asset(
                              'assets/animations/confetti.json',
                              width: 200,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ]),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                          child: Visibility(
                              visible: state.isEating,
                              child: DevilFruitType(devilFruit: widget.devilFruit)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Visibility(
                            visible: state.isEating,
                            child: Text(
                              '${AppLocalizations.of(context)!.justEat} ${widget.devilFruit.romanName}${AppLocalizations.of(context)!.getPower} ${widget.devilFruit.name}${AppLocalizations.of(context)!.weakWater}',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                        child: Visibility(
                            visible: state.isEating,
                            child: Text(
                              AppLocalizations.of(context)!.gallery,
                              style: Theme.of(context).textTheme.displayLarge,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Visibility(
                          visible: state.isEating,
                          child: DevilFruitGallery(type: widget.devilFruit.type),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}

class DevilFruitGallery extends StatelessWidget {
  final String type;

  const DevilFruitGallery({super.key, required this.type});

  static final Map<String, List<String>> imageMap = {
    'Paramecia': [
      'assets/images/paramecia-gif.gif',
      'assets/images/paramecia1.webp',
      'assets/images/paramecia2.jpeg',
      'assets/images/paramecia3.jpg',
      'assets/images/paramecia4.avif',
      'assets/images/paramecia5.avif',
    ],
    'Logia': [
      'assets/images/logia-gif.gif',
      'assets/images/logia1.webp',
      'assets/images/logia2.webp',
      'assets/images/logia3.webp',
      'assets/images/logia4.avif',
      'assets/images/logia5.avif',
    ],
    'Zoan': [
      'assets/images/zoan-gif.gif',
      'assets/images/zoan1.webp',
      'assets/images/zoan2.webp',
      'assets/images/zoan3.jpg',
      'assets/images/zoan4.jpg',
      'assets/images/zoan5.webp',
    ],
    'Smile': [
      'assets/images/smile0.webp',
      'assets/images/smile1.webp',
      'assets/images/smile2.png',
      'assets/images/smile3.gif',
      'assets/images/smile4.jpg',
      'assets/images/smile5.webp',
    ],
  };

  List<String> _getImagesByType(String type) {
    return imageMap[type] ?? imageMap['Zoan']!;
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = _getImagesByType(type);

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: ParallaxImage(
            imagePath: images[index],
          ),
        ),
        itemCount: images.length,
      ),
    );
  }
}

class ParallaxImage extends StatelessWidget {
  ParallaxImage({super.key, required this.imagePath});

  final GlobalKey _backgroundImageKey = GlobalKey();
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      // Create rounded corners for the image
      borderRadius: BorderRadius.circular(20.0),
      child: AspectRatio(
        // Define the aspect ratio for the image

        aspectRatio: 16 / 9,
        child: Flow(
          delegate: ParallaxFlowDelegate(
            /// Access the scrollable widget
            scrollable: Scrollable.of(context),

            // Context of the list item
            listItemContext: context,

            // Pass the background image key
            backgroundImageKey: _backgroundImageKey,
          ),
          // Apply anti-aliasing to the clipping
          clipBehavior: Clip.antiAlias,
          children: [
            Image.asset(
              imagePath,
              // Use the provided key for this image
              key: _backgroundImageKey,
              fit: BoxFit.cover, // Set the image to cover the available space
            ),
          ],
        ),
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject()! as RenderBox;
    final listItemBox = listItemContext.findRenderObject()! as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject()! as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    required ScrollableState scrollable,
  }) : _scrollable = scrollable;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child!;
    final backgroundImageConstraints =
        BoxConstraints.tightFor(width: size.width);
    background.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData! as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject()! as RenderBox;
    final backgroundOffset =
        localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
        (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child!;
    final backgroundSize = background.size;
    final listItemSize = size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData! as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}
