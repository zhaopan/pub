# sublime.setting

```javascript
{
    "auto_find_in_selection": true,
    "bold_folder_labels": true,
    "draw_white_space": "all",
    "ensure_newline_at_eof_on_save": true,
    "font_size": 14,
    "highlight_line": true,
    "highlight_modified_tabs": true,
    "save_on_focus_lost": true,
    "show_encoding": true,
    "show_line_endings": true,
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "trim_automatic_white_space": true,
    "trim_trailing_white_space_on_save": true,
    "update_check": false,
    "word_wrap": false,
}
```

## 插件

* `DeleteBlankLines`    删除空白行
* `DocBlockr`           注释
* `JsFormst`            JS格式化
* `PrettyJson`          json格式化
* `SFTP`                FTP同步
* `theme-Afterglow`     主题样式
* `sublimerge `         文件对比

## install package control

```python
import urllib.request,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp  = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try           manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```
