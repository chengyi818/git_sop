# git_sop 脚本使用说明

tags ： git

---

##前言
git是功能非常强大的版本管理工具，同时它带来的是学习成本的上升。最近我们团队的部分项目采用了git进行版本管理，一部分小伙伴对于git使用不是很熟悉。一方面要学习git的基本使用命令，另一方面还是遵守团队内部的git提交标准流程。
我写这个脚本旨在降低git的使用成本，根据28原则，只要掌握20%的操作命令，就可以应付80%的工作。

这是我们目前采用的[分支策略](http://mp.weixin.qq.com/s?__biz=MzAxODI5ODMwOA==&mid=212227888&idx=1&sn=1f5ed317868323b5ded102c62a5cb942#rd)。

##功能说明
启动脚本后，提供如下7个功能
```
1) develop a new feature
2) fix a bug in develop branch
3) push a branch for review
4) modify a branch after review failure
5) commit a branch after review success
6) review a branch
7) review a branch success
```
>1 从develop分支拉一个新的功能开发分支

>2 从develop分支拉一个bug修复分支

>3 将本地一个开发完成的功能分支推送到远程，提供给他人review

>4 在review后，如果还有不完善的地方，可以回到功能分支继续开发

>5 在review完成后，如果已经全部开发完成，将功能分支合入远程仓库develop分支

>6 作为CTT，review一个功能分支。

>7 在CTT，review完一个功能分支后，清理本地痕迹。



##尾记
作为日常使用而言，使用这个脚本，将使你的git操作行为完全符合我们的标准使用流程
其次，你只需要再掌握git add/commit/status等寥寥几个命令，就足以应付日常的使用。
这个脚本是我周末写出来的，虽然我已经做过基本的验证，同时脚本中也加入了一些保护机制。但是在使用过程中，难免会有什么错误，请联系我。Email：chengyi818@foxmail.com



