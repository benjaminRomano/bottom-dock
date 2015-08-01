# bottom-dock package

bottom-dock is an extendable panel which helps simplify creating panels.

Features:
* Hide/Show panel
* Reize panel
* Multiple panes
* Manages active tab and pane
* Easy refresh/delete pane

![image](https://cloud.githubusercontent.com/assets/9221137/9021445/2ae57064-37f7-11e5-9b99-426c8efdcb81.png)

#### BottomDockService API

```js
class BottomDockService {
  toggle(): void
  changePane(id: string): void
  refreshPane(id: string): void
  deletePane(id: string): void
  getPane(id: string): Pane //Where Pane extends DockPaneView
  addPane(pane: Pane, name: string): void
  getCurrentPane(): Pane
  refreshCurrentPane(): void
  deleteCurrentPane: void
  destroy: void //For internal use only
}
````

##### How to use
Create a new package that consumes the BottomDockService

Extend the DockPaneView from the [attom-bottom-dock](https://www.npmjs.com/package/atom-bottom-dock) npm package

Look at [Gulp Manager](https://github.com/benjaminRomano/gulp-manager) for an example on how to use the api
