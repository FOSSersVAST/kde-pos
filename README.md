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

* Set suggestions for all components & vote to 3 :

```
weblate shell -c 'from weblate.trans.models import Component; Component.objects.all().update(suggestion_voting=True, suggestion_autoaccept=3)'
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

## Pushing to KDE Upstream

NOTE: Don't make any change directly in KDE upstream branch. If doing so, make sure to update the PO file in this repo's `l10n-kf5` folder too.

* Run `copy-to-upstream.sh`