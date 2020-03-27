# vim基础命令行使用

## 实验目的

+ 熟练使用linux基本命令行

## 实验要求（完成度）

- [x]  确保本地已经完成**asciinema auth**，并在[asciinema](https://asciinema.org/)成功关联了本地账号和在线账号
- [x] 上传本人亲自动手完成的**vimtutor**操作全程录像
- [x] 在自己的github仓库上新建markdown格式纯文本文件附上asciinema的分享URL

## 实验环境

+ ubuntu18.04+vim
+ 在[asciinema](https://asciinema.org/)注册一个账号，并在本地安装配置好asciinema

## 实验先修知识（课堂笔记）

+ 软件包管理（命令行中tab键自动补全）

  ```
  sources.list格式 # /etc/apt/sources.list
  小心添加第三方软件源
  查找：apt-get update && apt-cache search、apt-file、google、dpkg -S、aptitude,apt show（查看软件包详细信息）
  dpkg -L |grep+安装包 （查看软件被安装到哪里）
  lsb -a #查看linux版本
  cat /etc/issue #定义当前系统
  安装：软件被装到哪里去了
  升级：区分upgrade与dist-upgrade
  卸载：purge、clean、remove
  purge #删除软件及配置
  clean #只删除软件不删除配置
  源码下载与安装
  README.md / INSTALL
  pwd #查看当前工作目录
  ls -a #查看隐藏文件
  man shred #文件安全删除
  ln #它的功能是为某一个文件在另外一个位置建立一个同步的链接
  find #文件名查找
  ```

+ vim

  ```bash
  vimdiff #查看两个文件的区别
  set nu # 查看行号
  ```

+ 文件管理

  - 扩展名查找
  - 通配符匹配
  - 按文件大小
  - 按文件更新时间早于、晚于、在日期之间
  - 查找到匹配后执行
    - `find ... -execdir xxx {} \`;
  - ps aux | grep #查看当前进程,
  
+ sed 

  + SED的英文全称是**Stream EDitor**，它是一个简单而强大的文本解析转换工具
  + 文本替换
  + 选择性的输出文本文件
  + 从文本文件的某处开始编辑
  + 无交互式的对文本文件进行编辑等

+ 目录管理、进程管理

## 实验步骤

- 首先安装 asciinema `sudo apt install asciinema`

- 关联本地账号和在线账号 `asciinema auth`

- vimtutor操作

  + 第一节教程学习

    [![asciicast](https://asciinema.org/a/BTXQARNGhFL8iTQVH6Jq7qzwO.png)](https://asciinema.org/a/BTXQARNGhFL8iTQVH6Jq7qzwO)
    
  + 第二节教程学习
  
    [![asciicast](https://asciinema.org/a/XzyDPuOUCXu0LrNDZvrU370Ug.png)](https://asciinema.org/a/XzyDPuOUCXu0LrNDZvrU370Ug)
  
  + 第三节教程学习
    
    [![asciicast](https://asciinema.org/a/DKJugUQkNQPo6ixhgwDxJJo0i.png)](https://asciinema.org/a/DKJugUQkNQPo6ixhgwDxJJo0i)
    
  + 第四节教程学习
  
    [![asciicast](https://asciinema.org/a/wOuJ2uzhKtnDi6eiEepEcBj9f.png)](https://asciinema.org/a/wOuJ2uzhKtnDi6eiEepEcBj9f)
    
  + 第五节教程学习
  
    [![asciicast](https://asciinema.org/a/pUSDxy6K97AVFgjmNUbrKWaC4.png)](https://asciinema.org/a/pUSDxy6K97AVFgjmNUbrKWaC4)
    
  + 第六节教程学习
  
    [![asciicast]( https://asciinema.org/a/gfJQOgBvD0xDdUbWWWRD1gADS.png)]( https://asciinema.org/a/gfJQOgBvD0xDdUbWWWRD1gADS)
    
  + 第七节教程学习
  
    [![asciicast]( https://asciinema.org/a/EmwzLu6K3Gmx4imf4GlHmQ0PW.png)]( https://asciinema.org/a/EmwzLu6K3Gmx4imf4GlHmQ0PW)
  



## 实验总结

+ vimtutor完成后的自查清单（vimtutor命令总结大全）
  + 你了解vim有哪几种工作模式？
    - 正常模式 (Normal-mode)
    - 插入模式 (Insert-mode)
    - 命令模式 (Command-mode)
    - 可视模式 (Visual-mode)
  + Normal模式下，从当前行开始，一次向下移动光标10行的操作方法？如何快速移动到文件开始行和结束行？如何快速跳转到文件中的第N行？
    - 向下移动光标十行：`10j`
    - 开始：`gg`
    - 结束：`G`
    - 第N行：`NG`
  + Normal模式下，如何删除单个字符、单个单词、从当前光标位置一直删除到行尾、单行、当前行开始向下数N行？
    - 单个字符：`x`
    - 单个单词：`dw`
    - 删除到行尾：`d$`
    - 删除单行：`dd`
    - 删除向下N行：`Ndd`
  + 如何在vim中快速插入N个空行？如何在vim中快速输入80个-？
    - 快速插入N个空行：`No`
    - 输入80个-：`80i-ESC`
  + 如何撤销最近一次编辑操作？如何重做最近一次被撤销的操作？
    - 撤销最近一次编辑操作：`u`
    - 重做最近一次被撤销的操作：`Ctrl+R`
  + vim中如何实现剪切粘贴单个字符？单个单词？单行？如何实现相似的复制粘贴操作呢？
    - 剪切粘贴
      - 单词字符：`xp`
      - 单词单词：`dwp`
      - 单行：`ddp`
    - 相似的复制粘贴操作
      - 进入`visual`模式之后选择要复制的内容，然后退出回到`normal`模式进行粘贴
      - 操作
        - `v` 进入 `visual` 模式
        - 选择要复制的内容
          - `^` 选中当前行，光标位置到行首
          - `$` 选中当前行，光标位置到行尾
          - `w` 到下一个单词首
        - `y` 复制操作
        - `ESC` 退回到`normal`模式
        - `p` 粘贴
  + 为了编辑一段文本你能想到哪几种操作方式（按键序列）？
    1. `vim filename`
    2. `i` 进入编辑
    3. 编辑完成，`ESC`回到`normal`模式
    4. `:wq`保存后退出
  + 查看当前正在编辑的文件名的方法？查看当前光标所在行的行号的方法？
    - 查看当前正在编辑的文件名和光标所在行号：`Ctrl+G`
    - 或者以下方法也可以查看光标所在行号：`:set number`
  + 在文件中进行关键词搜索你会哪些方法？如何设置忽略大小写的情况下进行匹配搜索？如何将匹配的搜索结果进行高亮显示？如何对匹配到的关键词进行批量替换？
    - 关键词搜索
      - `/keyword`
      - `?keyword`
    - 设置忽略大小写的情况下进行匹配搜索：`:set ic`
    - 将匹配的搜索结果进行高亮显示：`set hls is`
    - 对匹配到的关键词进行批量替换：`:%s/old/new/g`
  + 在文件中最近编辑过的位置来回快速跳转的方法？
    - 最近编辑过的位置来回快速跳转
      - 向前：`Ctrl+I`
      - 向后：`Ctrl+O`
  + 如何把光标定位到各种括号的匹配项？例如：找到(, [, or {对应匹配的),], or }
    1. 将光标移动到该括号
    2. 按下 `%` 进行匹配
  + 在不退出vim的情况下执行一个外部程序的方法？
    - 不退出vim的情况下执行一个外部程序：`:!+外部程序命令`
  + 如何使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法？如何在两个不同的分屏窗口中移动光标？
    - 使用vim的内置帮助系统来查询一个内置默认快捷键的使用方法：`:help`
    - 在两个不同的分屏窗口中移动光标：`Ctrl+W`



## 实验参考资料

+ [课程录屏](https://www.bilibili.com/video/BV1S7411W7J5)
+ [linux课本](https://github.com/c4pr1c3/LinuxSysAdmin/blob/master/chap0x02.md)
+ [sed学习](https://www.ituring.com.cn/article/273760)
+ [vimtutor中文教程](https://www.cnblogs.com/YooHoeh/p/10659695.html)







