# bottom-dock package

bottom-dock is a generic bottom dock for quick panel development

##### Commands
* ctrl-k ctrl-t: toggles panel
* ctrl-k ctrl-r: refreshes window
* ctrl-k ctrl-c: closes window

![image](https://cloud.githubusercontent.com/assets/9221137/8978100/c7a2f7aa-3653-11e5-8d03-b0bd3b0b5824.png)

#### API

```js
class BottomDockService {
  toggle(): void
  changePane(id: string): void
  refreshPane(id: string): void
  deletePane(id: string): void
  getPane(id: string): Pane //Where Pane is a sublcass of DockPaneView
  addPane(pane: Pane, name: string): void
  getCurrentPane(): Pane
  refreshCurrentPane(): void
  deleteCurrentPane: void
  destroy: void //For internal use only
}
````

##### How to use
Create a new package that consumes the [bottom-dock service](https://www.npmjs.com/package/atom-bottom-dock)

Extend the DockPaneView from the attom-bottom-dock npm package

Look at [Gulp Manager](https://github.com/benjaminRomano/gulp-manager) for an example on how to use the api
