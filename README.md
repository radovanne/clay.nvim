#  clay.nvim
** This plugin is still Work In Progress.**
** Changes will happen, things may break, but I will fix it. **

**A Neovim plugin for working with [Clay](https://github.com/scicloj/clay), the minimalistic Clojure tool for data visualization and literate programming.**

---

##  What is Clay?

[Clay](https://github.com/scicloj/clay) is a minimalistic Clojure tool for **visual data exploration** and **literate programming**, designed with the [Kindly](https://scicloj.github.io/docs/kindly/) convention in mind.

With Clay, you can:
-  Create visualizations from your Clojure code  
-  Turn Clojure source and comments into rich HTML documents: blog posts, slideshows, reports, and more  
-  Explore data in a visual and expressive way

---

##  What is `clay.nvim`?

`clay.nvim` brings Clay closer to your fingers — right inside Neovim.  
This plugin adds custom functions that integrate with the Clay v2 API, making it easier to:

- Start Clay sessions   
- Evaluate code and see the output   
- Generate hiccup and HTML   

Current usage depends on [Conjure](https://github.com/Olical/conjure).

---

## ⚙️ Installation (with `lazy.nvim`)

```lua
{
  "radovanne/clay.nvim",
  dependencies = { "Olical/conjure" },
  ft = { "clojure" },
  config = function()
    local clay = require("clay")
    local wk = require("which-key")
    wk.add({
      { "<localleader>c", group = "Connect/Clay" },
      { "<localleader>cb", clay.ClayBrowse, desc = "Clay Browse" },
      { "<localleader>cw", clay.ClayWatch, desc = "Clay Watch" },
      { "<localleader>ch", clay.ClayPrintNamespaceToHiccup, desc = "Print Namespace to Hiccup" },
      { "<localleader>cn", clay.ClayMakeFile, desc = "Render Namespace" },
      { "<localleader>cqn", clay.ClayMakeFileQuarto, desc = "Render Namespace with Quarto" },
      ...etc
    })
  end,
}
```

>  No keybindings are enforced — you're free to set them up however you'd like.

---
## 📘 Function List

* `ClayBrowse` →  Open the browser to the local Clay page
* `ClayWatch` →  Start watching notebooks directory for Clay updates
* `ClayPrintNamespaceToHiccup` →  Convert namespace to hiccup without rendering
* `ClayMakeFile` →  Render the current namespace to HTML
* `ClayMakeFileQuarto` →  Render the current namespace to Quarto
* `ClayMakeFileRevealjs` →  Render the current namespace to RevealJS
* `ClayMakeCurrentForm` →  Render the current form to HTML
* `ClayMakeTopLevelForm` →  Render the top-level form to HTML
* `ClayMakeCurrentFormQuarto` →  Render current form to Quarto
* `ClayMakeTopLevelFormQuarto` →  Render top-level form to Quarto

---
## 📦 Quarto & RevealJS Integration

`clay.nvim` supports both Quarto and RevealJS outputs.
You can render your forms or whole namespaces directly into beautiful documents and slides!

Use:

* `ClayMakeFileQuarto` or `ClayMakeTopLevelFormQuarto` for Quarto.
* `ClayMakeFileRevealjs` for RevealJS presentations.

---

## 🧩 VSCode & Neovim Parity
Clay works equally well in VSCode and Neovim, and clay.nvim is built to match the VSCode experience closely.

Check out the Calva (VSCode) configuration here:
🔗 Calva Clay Config ([config.edn](https://github.com/scicloj/clay))

> Whether you use Neovim or VSCode, you’ll get the same workflows and same Clay integration — and I’ll try to keep it that way going forward.
---

## 🧪 Example Usage

In deps.edn:
```clojure
{:paths ["src", "resources"]
 :deps {org.clojure/clojure {:mvn/version "1.12.0"}
        org.scicloj/clay {:mvn/version "2-beta39"}
        org.scicloj/kindly {:mvn/version "4-beta15"}
        scicloj/tablecloth {:mvn/version "7.042"}}}
```

In src/clay.clj:
```clojure
(ns clay
  (:require
   [scicloj.kindly.v4.kind :as kind]
   [scicloj.clay.v2.main]
   [tablecloth.api :as tc]))

;; Basic math visualisation
(+ 2 2 3)

;; A Hiccup spec:
(kind/hiccup
 [:div {:style {:background "#efe9e6"
                :border-style :solid}}
  [:ul
   [:li "one"]
   [:li "two"]
   [:li "three"]]])

;; A dataset using Tablecloth:
(-> {:x (range 5)
     :y (repeatedly 5 rand)}
    tc/dataset
    (tc/set-dataset-name "my dataset"))
```

Run the REPL, connect to it and run `:ClayBrowse` to start!

![image](./assets/images/clay.png)

---
Contributions are welcome!

That’s it — simple, minimal, and meant to stay out of your way.
Happy visualizing with Clay + Neovim! 🎨
