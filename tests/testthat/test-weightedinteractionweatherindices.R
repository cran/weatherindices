
test_that("i.wwi provides a yearly unweighted interaction weather indices", {
  i.wwi.prec.rh<-i.wwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation,Burdwanweather$Relative.Humidity)
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
  i.wwi=as.vector((t(rxxmat)%*%t(xxmat))/sum(rxx))
  expect_equal(i.wwi.prec.rh,i.wwi)
})


test_that("i.wwi provides a interaction weather indices for each year", {
  i.wwi.precipitation<-i.wwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation,Burdwanweather$Relative.Humidity)
  expect_equal(length(i.wwi.precipitation),length(Burdwanriceyield$burdwan))
})

test_that("i.wwi provides a numeric vector of interaction weather indices", {
  i.wwi.precipitation<-i.wwi(Burdwanriceyield$burdwan,Burdwanweather$Precipitation,Burdwanweather$Relative.Humidity)
  expect_type(i.wwi.precipitation,"double")
  is.numeric(i.wwi.precipitation)
})
