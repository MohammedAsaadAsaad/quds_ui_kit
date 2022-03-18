# Quds UI Kit

This library consists of:
* Animating widgets with simple controlling, events capturing.
* Page Transitions
* Toasts
* Bottom sheets
* Dialogs
* Pagination
* Simple Drawer
* Splash Screen View
* Another Viewers

To use this package see the following [ example](https://github.com/MohammedAsaadAsaad/quds_ui_kit/tree/master/example).

## Animation:
### Icons:
* <b>QudsAnimatedIcon</b>
<br>A wrap widget to control Flutter AnimatedIcon easily.
```
 QudsAnimatedIcon(
            iconData: AnimatedIcons.play_pause,
            showStartIcon: _isPlaying,
          )
```
![](https://i.imgur.com/YR3i4Jd.gif)

<br>What if desired to combine another two icons?
<br>
* <b>QudsAnimatedCombinedIcons</b>
<br>Combines any two icons and make a transition!

```
 QudsAnimatedCombinedIcons(
        startIcon: Icons.accessible,
        endIcon: Icons.accessibility_new,
        showStartIcon: _onChair,
      ),
```
![](https://i.imgur.com/q8UC6Zf.gif)

<br><br>
You can customize the sizes, colors, transition duration and curve, ..etc.
<br/>
![](https://i.imgur.com/ybqHKgV.gif)
<br/>
<br/>
* QudsAnimatedText
<br/>
```
QudsAnimatedText(
          _isPlaying ? 'Playing' : 'Paused',
        )
```
<br/>![](https://i.imgur.com/N1oWxLD.gif)

* QudsAnimatedCounter
<br>
```
QudsAnimatedCounter(
        counter,
        duration: Duration(milliseconds: 200),
        length: 4,
        style: TextStyle(fontSize: 30),
      )
```
<br>

![](https://i.imgur.com/SnzKmlu.gif)
<br>
<br>
<br>

### Buttons
  All animated icons in this library wrapped in buttons with capturing tap ability.
```
QudsAnimatedCombinedIconsButton(
            tooltip: 'Toggle',
            startIcon: Icons.arrow_forward,
            // startIconColor: Colors.white,
            onPressed: _toggle,
          ),
``` 

Other Buttons:
- QudsAnimatedIconButton
- QudsAnimatedCombinedIconsButton
- QudsCheckbox
- QudsCheckboxListTile
- QudsCheckboxWithText


![](https://i.imgur.com/klKJ0Rg.gif)
<br>
<br>

## Page Transitions
Wide collection of page route tranistion are now supported in `Quds UI Kit`
* Fade QudsFadePageRoute({duration, curve})
* Rotation QudsRotatePageRoute({duration, curve, alignment})
* Slide QudsSlidePageRoute({direction[`Up` `Down` `Left` `Right` `Start` `End`], duration, curve})
* Zoom QudsZoomPageRoute({duration, curve, alignment})
* Combined QudsTransitionPageRoute({withFade, withRotate, withSlide, withScale, rotateAlignment, scaleAlignment, duration, curve})

```
Navigator.push(
                context,
                QudsSlidePageRoute(
                  builder: (c) => _SecondScreen(),
                  slideDirection: SlideDirection.Up, //Default [SlideDirection.Start]
                ))
```
![](https://imgur.com/Te1G7ib.gif)

## Toasts
Customized toasts with easy control,
```
showQudsToast(context,
                  content: Text('Copied!'),
                  toastTime: QudsToastTime.VeryShort,
                  leadingActions: [
                    QudsAutoAnimatedCombinedIcons(
                      startIcon: Icons.copy,
                      endIcon: Icons.paste,
                      showStartIcon: false,
                    )
                  ])
```

<br>

![](https://i.imgur.com/APyLKRr.gif)


## Bottom Sheets
```
showQudsModalBottomSheet(
              context,
              (c) => Column(
                    children: [
                      for (int i = 0; i < 5; i++) ListTile(title: Text('Hi'))
                    ],
                  ),
              titleText: 'Test Bottom Sheet')
```

![](https://i.imgur.com/virjcL9.gif)

<br><br><br>

## Pagination
```
QudsCollectionPagination<_ExampleModel>(
        resultsPerPage: itemsPerPage,
        itemsPadding: EdgeInsets.all(2),
        onResultsPerPageChanged: (p) {
          page = 1;
          itemsPerPage = p;
          _fillItems();
        },
        currentPageItems: currItems,
        onPageChanged: (p) {
          page = p;
          _fillItems();
        },
        selectedPage: page,
        total: provider.list.length,
        itemBuilder: (c, i, o) => ListTile(
          title: Text(o.name),
          subtitle: Text(o.id.toString()),
        ),
      )
```
![](https://i.imgur.com/9zXvsPF.png)

<br><br>

## Dialogs
* General Dialogs<br>
In general, to show a dialog, user showQudsDialog, for example:
```
    showQudsDialog(context,
            title: Text('Save'),
            builder: (c) => Text(
                    'Would you like to save the document before existing?'));
```

* Pre-prepared dialogs:<br>
This package provides some pre-customized dialogs:
```
 showQudsConfirmDeleteDialog(context,
              onDeletePressed: () => showQudsToast(context,
                  toastTime: QudsToastTime.VeryShort,
                  leadingActions: [
                    QudsAutoAnimatedCombinedIcons(
                        startIcon: Icons.delete, endIcon: Icons.done)
                  ],
                  content: Text('Deleted!'),
                  trailingActions: [
                    InkWell(
                        onTap: () {
                          showQudsToast(context,
                              toastTime: QudsToastTime.VeryShort,
                              content: Text('Undo pressed'));
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: QudsAutoAnimatedCombinedIcons(
                              startIcon: CupertinoIcons.delete,
                              endIcon: CupertinoIcons.arrow_turn_up_left,
                              showStartIcon: false,
                            )))
                  ]))
```

<br>

![](https://i.imgur.com/jUzQZi5.gif)

## QudsLightDrawer
```

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QudsLightDrawer(
      bottomAboutButton: ...,
      bottomButton: ...,
      body: ...;
  }
}
```

![](https://i.imgur.com/lcO7Xlr.png)

## QudsPopupMenu
``` dart
    QudsPopupButton(
              // backgroundColor: Colors.red,
              tooltip: 'T',
              items: getMenuItems(),
              child: Icon(Icons.menu)),
      
    
List<QudsPopupMenuBase> getMenuItems() {
    return [
      QudsPopupMenuSection(
          backgroundColor: Colors.yellow.shade200,
          titleText: 'أبو أسعد الأمير',
          subTitle: Text('See your profile'),
          leading: Icon(
            Icons.redeem,
            size: 40,
          ),
          subItems: [
            QudsPopupMenuSection(
                titleText: 'Settings',
                leading: Icon(Icons.settings),
                subItems: [
                  QudsPopupMenuItem(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onPressed: () {
                        showToast('Logout Pressed!');
                      })
                ]),
          ]),
      QudsPopupMenuDivider(),
      QudsPopupMenuItem(
          leading: Icon(Icons.info_outline),
          title: Text('Give Feedback'),
          subTitle: Text('Help us improve our new app'),
          onPressed: () {
            showToast('Feedback Pressed!');
          }),
      QudsPopupMenuDivider(),
      QudsPopupMenuSection(
          leading: Icon(Icons.place),
          titleText: 'Settings & Privacy',
          subItems: [
            QudsPopupMenuItem(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onPressed: () {
                  showToast('Settings Pressed!');
                }),
            QudsPopupMenuItem(
                leading: Icon(Icons.lock),
                title: Text('Privacy Checkup'),
                onPressed: () {
                  showToast('Privacy Checkup Pressed!');
                }),
            QudsPopupMenuItem(
                leading: Icon(Icons.lock_clock),
                title: Text('Privacy Shortcuts'),
                onPressed: () {
                  showToast('Privacy Shourtcuts Pressed!');
                }),
            QudsPopupMenuItem(
                leading: Icon(Icons.list),
                title: Text('Activity Log'),
                onPressed: () {
                  showToast('Activity Log Pressed!');
                }),
            QudsPopupMenuItem(
                leading: Icon(Icons.card_membership),
                title: Text('News Feed Preferences'),
                onPressed: () {
                  showToast('News Feed Preferences Pressed!');
                }),
            QudsPopupMenuItem(
                leading: Icon(Icons.language),
                title: Text('Language'),
                onPressed: () {
                  showToast('Language Pressed!');
                }),
          ]),
      QudsPopupMenuDivider(),
      QudsPopupMenuWidget(
          builder: (c) => Container(
              padding: EdgeInsets.all(10),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          showToast('Favourite Pressed!');
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                    VerticalDivider(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.music_note,
                          color: Colors.blue,
                        )),
                    VerticalDivider(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.umbrella,
                          color: Colors.green,
                        ))
                  ],
                ),
              )))
    ];
  }
        
```
![](https://i.imgur.com/kw8s7W4.gif)

## QudsSplashView

```
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QudsSplashView( 
      progressIndicator: ...,
      futures: [...],
      onCompleted: ...,
      ),
    );
  }
}
```
<br><br>

## Another Viewers

* For specific time
```
 QudsDigitalTimeViewer(
        hour: 10,
        minute: 59,
        second: 40,
        milliSecond: 10,
      ),
```

* For live time:
```
QudsDigitalClockViewer(
        showSeconds: true,
        showMilliSeconds: true,
      )
```

![](https://i.imgur.com/CZCIT8p.gif)