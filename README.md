# kde-pos

## Setup

KDE Malayalam PO files are stored here.

* Import to weblate :

```bash
weblate import_project kde 'https://github.com/FOSSersVAST/kde-pos.git' master "l10n-kf5/(?P<language>[^/]*)/(?P<component>[^%]*)\.po" 
```

* Fix values in database :

```sql
UPDATE lang_plural SET equation='(n != 1)' WHERE equation='n != 1'
UPDATE trans_component SET license='Under the same license as the package', new_lang='none';
```

* Set suggestions for all components & vote to 3.
  Disable translation propagation (because it screws up `Your names` and `Your emails` strings)

```
weblate shell -c 'from weblate.trans.models import Component; Component.objects.all().update(suggestion_voting=True, suggestion_autoaccept=3, allow_translation_propagation=False)'
```

* Then do

```bash
weblate loadpo kde
```

* Make project suggestion-review based (Project -> Users) :
  * Project Access Control : Protected
  * Enable Reviews : Yes

* In this repo, make a folder `upstream`. It's structure :
  upstream
  - l10n-kf5-trunk
    - ml
      ```bash
      svn co svn+ssh://svn@svn.kde.org/home/kde/trunk/l10n-kf5/ml/messages ml
      ```
    - templates
      ```bash
      svn co svn+ssh://svn@svn.kde.org/home/kde/trunk/l10n-kf5/templates/messages templates
      ```
  - stable-kf5

## Syncing with KDE Upstream

NOTE: Don't make any change directly in KDE upstream branch. If doing so, make sure to update the PO file in this repo's `l10n-kf5` folder too.

* In `upstream/l10n-kf5-trunk/ml`, do `svn update`
* Copy files from upstream to this repo's `l10n-kf5` (This will only `cp` files that are in this repo from upstream)
  ```bash
  copy-from-upstream.sh
  ```
* Commit & push
  ```
  git commit -a -m "Sync with KDE Upstream"
  ```
* Go to weblate, pull changes, commit & push
* `git pull` here
* Run
  ```bash
  copy-to-upstream.sh
  ```
* In upstream,
  ```bash
  svn commit -m 'Update malayalam'
  ```

Steps till Weblate pull can be done periodically to keep Weblate POs up-to-date with upstream.

## Adding a new component

Copy file from upstream to corresponding one in `l10n-kf5` folder.

## Searching for strings

To search for a particular string, do this in upstream :

```
grep -rnw '.' --include="*.po" -e '"Open Path"'
```