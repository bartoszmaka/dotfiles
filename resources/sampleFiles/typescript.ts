import { Notification } from 'components/utils/types';

export class FooLayout {
  private menu: HTMLElement;
  private static instance: FooLayout;

  public static start() {
    const appLayout = new FooLayout();
    FooLayout.instance = appLayout;
  }

  constructor() {
    this.menu = this.getElementById('menu');
    this.enableToggleButtons('.toggle-menu', () => this.toggle(this.menu) );
  }

  static addNotification(notification: Notification) {
    window.notificationsInstance.addNotification(notification);
  }

  static setNotification(notification: Notification) {
    window.notificationsInstance.setNotification(notification);
  }

  private getElementById(id: string): HTMLElement {
    var element = document.getElementById(id)
    if (!element) {
      throw `Element with id: ${id} not found in the document`;
    }

    return element;
  }

  private enableToggleButtons(selector: string, toggleFunction: () => void) {
    var toggleButtons = document.querySelectorAll(selector);
    for (var index = 0; index < toggleButtons.length; index++) {
      toggleButtons[index].addEventListener('click', function() {
        toggleFunction();
      });
    }
  }

  private toggle(element: HTMLElement) {
    if (element.style.display === 'block') {
      element.style.display = '';
    } else {
      this.showBlockElement(element);
    }
  }

  private showBlockElement(element: HTMLElement) {
    element.style.display = 'block';
  }
}
