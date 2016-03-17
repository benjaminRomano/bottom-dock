# bottom-dock package

bottom-dock is an extendable panel which helps simplify creating panels.

Features:
* Hide/Show panel
* Resize panel
* Multiple panes
* Manages active tab and pane
* Easy add/delete pane

Commands:
* ctrl-k ctrl-t: toggles panel
* ctrl-k ctrl-r: refreshes window
* ctrl-k ctrl-c: closes window

![image](https://cloud.githubusercontent.com/assets/9221137/13841672/4fcc555e-ebf8-11e5-8cd3-e99571e3de9d.png)

#### BottomDockService API

```js
class BottomDockService {
  isActive(): boolean
  toggle(): void
  changePane(id: string): void
  deletePane(id: string): void
  getPane(id: string): Pane //Where Pane extends DockPaneView
  addPane(pane: Pane, tab: TabButton, isInitial?: boolean): void
  getCurrentPane(): Pane
  deleteCurrentPane: void
  onDidChangePane(callback: (id: string) => void): Disposable
  onDidDeletePane(callback: (id: string) => void): Disposable
  onDidAddPane(callback: (id: string) => void): Disposable
  onDidFinishResizing(callback: () => void): Disposable
  onDidToggle(callback: () => void): Disposable
  paneCount(): number
}
```

##### How to use
Create a new package that consumes the BottomDockService

Extend the DockPaneView from the [atom-bottom-dock](https://www.npmjs.com/package/atom-bottom-dock) npm package

Look at [Gulp Manager](https://github.com/benjaminRomano/gulp-manager) for an example on how to use the api
