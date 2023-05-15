
test_that("i.uwwi provides a yearly unweighted interaction weather indices", {
  i.uwwi.prec.rh<-i.uwwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation,Burdwanweather$Relative.Humidity)
  t=1:length(Burdwanriceyield$burdwan)
  week=1:(length(Burdwanweather$Precipitation)/length(t))
  wp1=data.frame(matrix(Burdwanweather$Precipitation,nrow=length(Burdwanriceyield$burdwan),byrow=T))
  colnames(wp1)=1:length(week)
  wp2=data.frame(matrix(Burdwanweather$Relative.Humidity,nrow=length(Burdwanriceyield$burdwan),byrow=T))
  colnames(wp2)=1:length(week)
  xx=wp1*wp2
  detrended.y=(Burdwanriceyield$burdwan-(lm(Burdwanriceyield$burdwan~t)$fitted))
  cor(xx[,1:length(week)],detrended.y)
  rxx=cor(xx[,1:length(week)],detrended.y)
  rxxmat=matrix(rxx[,1])
  xxmat=as.matrix(xx)
  i.uwwi=as.vector((t(rxxmat^0)%*%t(xxmat))/sum(rxx^0))
  expect_equal(i.uwwi.prec.rh,i.uwwi)
})


test_that("i.uwwi provides a interaction weather indices for each year", {
  i.uwwi.precipitation<-i.uwwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation,Burdwanweather$Relative.Humidity)
  expect_equal(length(i.uwwi.precipitation),length(Burdwanriceyield$burdwan))
})

test_that("i.uwwi provides a numeric vector of interaction weather indices", {
  i.uwwi.precipitation<-i.uwwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation,Burdwanweather$Relative.Humidity)
  expect_type(i.uwwi.precipitation,"double")
  is.numeric(i.uwwi.precipitation)
})
