# word
```
XWPFDocument doc = new XWPFDocument();
XWPFParagraph paragraph = doc.createParagraph();
XWPFRun runX = paragraph.createRun();

//默认：宋体（wps）/等线（office2016） 5号 两端对齐 单倍间距
runX.setText("舜发于畎亩之中， 傅说举于版筑之间， 胶鬲举于鱼盐之中， 管夷吾举于士...");
runX.setBold(false);//加粗
runX.setCapitalized(false);//我也不知道这个属性做啥的
//runX.setCharacterSpacing(5);//这个属性报错
runX.setColor("BED4F1");//设置颜色--十六进制
runX.setDoubleStrikethrough(false);//双删除线
runX.setEmbossed(false);//浮雕字体----效果和印记（悬浮阴影）类似
//runX.setFontFamily("宋体");//字体
runX.setFontFamily("华文新魏", FontCharRange.cs);//字体，范围----效果不详
runX.setFontSize(14);//字体大小
runX.setImprinted(false);//印迹（悬浮阴影）---效果和浮雕类似
runX.setItalic(false);//斜体（字体倾斜）
//runX.setKerning(1);//字距调整----这个好像没有效果
runX.setShadow(true);//阴影---稍微有点效果（阴影不明显）
//runX.setSmallCaps(true);//小型股------效果不清楚
//runX.setStrike(true);//单删除线（废弃）
runX.setStrikeThrough(false);//单删除线（新的替换Strike）
//runX.setSubscript(VerticalAlign.SUBSCRIPT);//下标(吧当前这个run变成下标)---枚举
//runX.setTextPosition(20);//设置两行之间的行间距//runX.setUnderline(UnderlinePatterns.DASH_LONG);//各种类型的下划线（枚举）
//runX0.addBreak();//类似换行的操作（html的  br标签）
runX0.addTab();//tab键
runX0.addCarriageReturn();//回车键

注意：addTab()和addCarriageReturn() 对setText()的使用先后顺序有关：比如先执行addTab,再写Text这是对当前这个Text的Table，反之是对下一个run的Text的Tab效果
```