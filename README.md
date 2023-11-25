# leap-zh.nvim

基于leap.nvim的中文词跳转

## 安装

```lua
-- dependency 可以不要
  { 'noearc/leap-zh.nvim', dependencies = { 'noearc/jieba-lua' } }, ```

## 键位

* 自行选择以下 function 要如何映射，示例：

```lua
map.set('n', 'fs', ":lua require'leap-zh'.leap_zh()<CR>") -- 向下搜索
map.set('n', 'fb', ":lua require'leap-zh'.leap_zh_bak()<CR>") -- 向上搜索
map.set('n', 'fw', ":lua require'leap-zh'.leap_jieba()<CR>") -- 搜索当前行的中文词
```
