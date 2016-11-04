
var tabs = [];
var elmApp;

function loadCurrentTabs() {
  chrome.windows.getCurrent(function(anaemicCurrentWindow) {
    chrome.windows.get(anaemicCurrentWindow.id, {"populate": true}, function(currentWindow) {
      tabs = currentWindow.tabs;
      // TODO - CAS - 05/11/15 - Don't use es6 lambda syntax here; not all Chrome versions recognise this yet (e.g. Linux)
      elmApp.ports.allTabs.send(tabs.map(tab => ({id: tab.id, url: tab.url, title: tab.title})));
      document.getElementById("filter").focus();
    });
  });
}

function log(msg) { console.log(msg); }

function remove(tabIdsToRemove) {
  chrome.tabs.remove(tabIdsToRemove);
}

function goTo(tabId) {
  chrome.tabs.update(tabId, {selected: true});
}

function deployedInChrome() {
  return typeof chrome.windows != "undefined";
}

var x = {};
function storePages(pages, tags) {
  pages.forEach(page => {
    page.tags = tags;
  page.date = new Date().toISOString();
  localStorage.setItem(page.url, JSON.stringify(page));
});
}

function unstorePages(pages) {
  pages.forEach(page => {
    localStorage.removeItem(page.url);
});
}

function storeTags(tags) {
  localStorage.setItem("tags", JSON.stringify(tags))
}

function retrieveTrees() {
  var trees = [];

  var trees = localStorage.getItem("tags");

  var max = localStorage.length;
  for (var i = 0; i < max; i++) {
    var key = localStorage.key(i);
    var value = localStorage.getItem(key);
    if (key != "tags") trees.push(JSON.parse(value));
  }

  elmApp.ports.allHistoricalPages.send(trees.map(defaultDate));
}

// TODO - CAS - 22/03/2016 - Temporary - all data should have dates
function defaultDate(page) {
  if (!page.hasOwnProperty("date")) page["date"] = new Date().toISOString();
  return page;
}

function retrieveTags() {
  var tags = localStorage.getItem("tags");
  if (tags) elmApp.ports.allTags.send(JSON.parse(tags));
}

function openPage(url) {
  window.open(url);
}

function select() {
  document.getElementById("filter").select();
}

function focus() {
  document.getElementById("filter").focus()
}

function embedElm() {
  elmApp = Elm.Main.fullscreen();

  elmApp.ports.browser.subscribe(function(cmd) {
    switch (cmd.commandType) {
      case "remove": remove(cmd.tabIds); break;
      case "goto":   goTo(cmd.tabIds[0]); break;
      case "open":   openPage(cmd.url); break;
      case "select": select(); break;
      case "focus":  focus(); break;
      case "log":    log(cmd.tabIds[0]); break;
      default:       log(cmd.commandType);
    }
  });

  elmApp.ports.storage.subscribe(function(push) {
    switch (push.pushType) {
      case "tags":   storeTags(push.tags); retrieveTags();break;
      case "pages":  storePages(push.pages, push.tags); retrieveTrees(); break;
      case "forget": unstorePages(push.pages); retrieveTrees();break;
      default:       log(push.storageType);
    }
  });
}

function bootStrap() {
  embedElm();

  // Workaround for Elm bug #595 - ports don't work immediately - https://github.com/elm-lang/core/issues/595
  setTimeout(function () {
    retrieveTrees();
    retrieveTags();
  }, 0);
}

window.addEventListener("load", bootStrap);
