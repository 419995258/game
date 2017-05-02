<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>打飞机游戏</title>
<script id="jquery_172" type="text/javascript" class="library"
	src="js/jquery.min.js"></script>
</head>
<style>
body {
	margin: 0;
	padding: 0;
	background: #000;
	font-family: microsoft yahei;
}

#box {
	width: 300px;
	height: 500px;
	margin: 10px auto;
	overflow: hidden;
	position: relative;
	border: 15px solid #f0f0f0;
	background: #000;
}

#box .title {
	width: 300px;
	height: 40px;
	line-height: 40px;
	position: absolute;
	left: 0;
	top: 80px;
	z-index: 1;
	color: #fff;
	text-align: center;
	font-size: 24px;
}

#box .difficulty {
	width: 300px;
	position: absolute;
	top: 180px;
	z-index: 1;
	font-family: microsoft yahei;
}

#box .difficulty a {
	width: 180px;
	height: 30px;
	line-height: 30px;
	text-align: center;
	display: block;
	margin: 20px auto 0 auto;
	background: #f0f0f0;
	color: #333;
	text-decoration: none;
}

#box .difficulty a:hover {
	background: #900;
	color: #fff;
}

#box .bg img {
	display: block;
}

#box .warcraft {
	width: 60px;
	height: 36px;
	position: absolute;
	left: 120px;
	top: 500px;
	background: url('img/warcraft.png') center no-repeat;
	z-index: 3;
}

#box .bullet {
	width: 6px;
	height: 22px;
	background: url('img/bullet.png');
	position: absolute;
	z-index: 2
}

#box .enemy {
	width: 23px;
	height: 30px;
	background: url('img/enemy.png');
	position: absolute;
	z-index: 3
}

#box .score {
	width: 220px;
	height: 30px;
	line-height: 30px;
	position: absolute;
	color: #fff;
	font-weight: bold;
	padding-left: 5px;
	font-size: 16px;
	z-index: 5;
}

#box .tips {
	width: 240px;
	height: 200px;
	line-height: 40px;
	padding: 10px;
	position: absolute;
	left: 20px;
	top: 130px;
	background: #f0f0f0;
}

#box .tips .type {
	width: 160px;
	padding: 2px 15px;
	height: 30px;
	line-height: 30px;
	text-align: center;
	color: red;
	font-weight: bold;
}

#box .tips p {
	width: 160px;
	height: 40px;
	font-size: 32px;
	line-height: 40px;
	text-align: center;
	cursor: pointer;
	background: #333;
	color: #fff;
	margin: 20px auto 0 auto;
}

#box .tips .nn,#box .tips .tt {
	padding: 2px 10px;
	font-weight: bold;
	color: blue;
}

#box .tips .tt {
	display: block;
	text-align: center;
	font-size: 24px;
}
</style>

<body>
	
	
	<audio controls="controls" hidden="hidden" autoplay="autoplay" loop="loop">
			<source src="audio/BGM.mp3"></source>
		</audio>
	

	<div id="box"></div>



	<script>

$(function () {
	game.startScreen.draw();
})


var game = {
	
	stage : $("#box"),
	
	modetxt : "",
	
	timer : {
		bg : null,
		bullet : null,
		enemy : null
	},
	mode : [
		[7,2500,500,1000,4000,200],//碰撞体积 、子弹速度越大越慢、发弹速度越大越慢、飞机下落最快速度越小越快、飞机下落最慢速度、x轴飞机生成数量
		[5,2000,300,3000,6000,300],
		[3,1500,50,4000,8000,400]
	], //参数配置
	num : {
		count : 0,
		warcraftX : 0,
		warcraftY : 0,
		score : 0
	},
	stitle : function ( score ) {
		switch ( game.modetxt ) {
			case '困难模式' : 
				if( score == 0 ) {
					return '不屈白银';
				}
				else if( score <= 20000 ) {
					return '荣耀黄金'
				}
				else if( score <= 100000 && score > 20000 ) {
					return '华贵铂金'
				}
				else if( score <= 500000 && score > 100000 ) {
					return '璀璨钻石'
				}
				else {
					return '最强王者';
				}
			case '普通模式' : 
				if( score == 0 ) {
					return '不屈白银';
				}
				else if( score <= 20000 ) {
					return '荣耀黄金'
				}
				else if( score <= 100000 && score > 20000 ) {
					return '华贵铂金'
				}
				else if( score <= 500000 && score > 100000 ) {
					return '璀璨钻石'
				}
				else {
					return '最强王者';
				}
			case '简单模式' : 
				if( score == 0 ) {
					return '不屈白银';
				}
				else if( score <= 20000 ) {
					return '荣耀黄金'
				}
				else if( score <= 100000 && score > 20000 ) {
					return '华贵铂金'
				}
				else if( score <= 500000 && score > 100000 ) {
					return '璀璨钻石'
				}
				else {
					return '最强王者';
				}
		}
	},
	startScreen : {
		draw : function () {
			var title = $("<div>");
				title.addClass("title");
				title.html("打飞机游戏");
				game.stage.append(title);
			
			var difficulty = $("<div>");
				difficulty.addClass("difficulty");
				difficulty.html("<a href='javascript:void(0)'>困难模式</a><a href='javascript:void(0)'>普通模式</a><a href='javascript:void(0)'>简单模式</a>");
				game.stage.append(difficulty);
			game.stage.find($(".difficulty")).delegate("a","click", function ( e ) {
				game.stage.start = true ;
				game.startScreen.remove();
				$(document).mousemove( function ( e ) {
					if( game.num.count % 2 == 0 && game.stage.start)
					{
						var e = e || event;
						var x = e.clientX - game.stage.offset().left - 10;
						var y = e.clientY - game.stage.offset().top - 10;
						game.core.warcraft([x,y]);
					}
					game.num.count++;
				})
				var set = game.mode[$(this).index()];
				game.modetxt = $(this).html();
				game.core.draw(set[0]);
				game.timer.bullet = setInterval ( function () {
					game.core.bullet(set[1],[game.num.warcraftX,game.num.warcraftY]);
				},set[2]);
				game.timer.enemy =setInterval ( function () {
					game.core.enemy({
						speed : game.randomNum(set[3],set[4]),
						left : game.randomNum(0,277),
						top : -game.randomNum(30,80)
					});
				},set[5])
			
			});
		}, //绘制开始界面
		remove : function () {
			var removeDiv = game.stage.children($("div"));
			removeDiv.stop().animate({opacity:0},100);
			setTimeout( function () {
				removeDiv.remove();
			},300)
		}
	}, //开始场景
	core : {
		draw : function ( speed ) {
			var warcraft = $("<div>");
				warcraft.addClass("warcraft");
			game.stage.append(warcraft);
			var score = $("<div>");
				score.addClass("score");
				score.html("0");
			game.stage.append(score);
		}, //绘制游戏场景
		warcraft : function ( pos ) { 
			var warcraft = game.stage.find($(".warcraft")),
				left =  pos[0] -warcraft.width()/2 - 3,
				top =  pos[1] - warcraft.height()/2 - 6;
			
			if( left <= -warcraft.width()/2 ) {
				left = -warcraft.width()/2;
			}
			else if( left >= game.stage.width() - warcraft.width()/2) {
				left = game.stage.width() - warcraft.width()/2;
			}
			if( top <= 0) {
				top = 0;
			}
			else if ( top >= game.stage.height() - warcraft.height()) {
				top = game.stage.height() - warcraft.height();
			}
			warcraft.css({left:left,top:top});
			game.num.warcraftX = left + warcraft.width()/2;
			game.num.warcraftY = top + warcraft.height()/2;
		}, //战斗机位置
		bullet : function ( speed ,pos ) {
			var bullet = $("<div>");
				bullet.addClass("bullet");
			game.stage.append(bullet);
			bullet.css({
					left : pos[0] - bullet.width()/2,
					top : pos[1] - bullet.height()/2
				});
			bullet.stop().animate({top:-bullet.height()},speed,function () { bullet.remove();})
		}, //子弹开始发射
		enemy : function ( argument ) {
			var speed = argument.speed;
			var left = argument.left;
			var top = argument.top;
			var oEnemy  = $("<div>");
				oEnemy.addClass("enemy");
				oEnemy.css({
					left : left,
					top : top
				});
			oEnemy.appendTo(game.stage);
			oEnemy.stop().animate( { top:530 }, speed , function () { oEnemy.remove(); clearInterval(oEnemy.timer)});
			oEnemy.timer = setInterval ( function () {
				var x = parseInt(oEnemy.css("left")) + 12,
					y = parseInt(oEnemy.css("top")) + 15,
					l = $(".bullet").length;
				for( var i = 0 ; i< l; i++ )
				{
					var bx = Math.abs( x - parseInt($(".bullet").eq(i).css("left"))),
						by = Math.abs( y - parseInt($(".bullet").eq(i).css("top")));
					if( bx <= 14 &&  by <= 20 )
					{
						oEnemy.css("background","url('img/boom.png')");
						$(".bullet").eq(i).remove();
						clearInterval(oEnemy.timer);
						game.num.score++;
						game.stage.find($(".score")).html(game.num.score*1000);
						setTimeout( function () { oEnemy.remove(); },300)
					}
				}
				var bx2 = Math.abs( x - parseInt($(".warcraft").css("left")) - 30),
					by2 = Math.abs( y - parseInt($(".warcraft").css("top")) - 18);
				if( bx2 <= 40 &&  by2 <= 33 )
				{
					var tips = $("<div>");
						tips.addClass("tips");
						tips.html("您在<span class='type'>" + game.modetxt.substring(0,4) + "</span>中以<span class='nn'>"+$(".score").html() + "</span>分荣获段位<span class='tt'>"+game.stitle($(".score").html())+"</span><p>再打一次</p>");
						game.stage.delegate(".tips p",'click',function(){
							game.num.score = 0;
							game.startScreen.remove();
							game.startScreen.draw();
						})
					oEnemy.remove();
					$(".score").css("display","none");
					$(".warcraft").css("background","url('img/boom2.png')");
					clearInterval(oEnemy.timer);
					setTimeout( function () { $(".warcraft").remove(); },300)
					clearInterval(game.timer.bullet);
					clearInterval(game.timer.enemy);
					clearInterval(game.timer.bg);
					setTimeout( function () {
						game.stage.append(tips);
					},3000)
					
				}
			},50)
		} //敌机

	}, //核心代码
	randomNum : function (a,b){
		var value = Math.abs(a-b) , num ;
		num = parseInt(Math.random()*(value)) + Math.min(a,b);
		return num;
	} //产生指定区域整形随机数。
};

	
</script>
	<div style="text-align:center;clear:both;margin-top:10px">
		<script src="/gg_bd_ad_720x90.js" type="text/javascript"></script>
		<script src="/follow.js" type="text/javascript"></script>
	</div>

</body>
</html>
