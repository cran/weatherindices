
#' Weighted Interaction Weather Indices
#' @description Converts the weekly interaction of two weather variable into yearly weighted interaction weather indices with weights being the correlation coefficient between weekly weather data over the years and crop yield over the years
#' @param y A vector of yearly yield data for t years
#' @param weatherp1 Weekly weather data for t years as vector for first weather variable(total observations= number of years*number of weeks in each year)
#' @param weatherp2 Weekly weather data for t years as vector for second weather variable(total observations= number of years*number of weeks in each year)
#'
#' @return A vector of interaction weather indices
#' @export
#' @references Jain, R. C., Agrawal, R., & Jha, M. P. (1980). Effect of climatic variables on rice yield and its forecast. MAUSAM, 31(4), 591-596.
#' @examples
#' data(Burdwanweather) #Weekly weather data for the rice growing season in Burdwan
#' data(Burdwanriceyield) #Yearly Yield data of rice  in Burdwan
#' i.wwi.maxmintem<-i.wwi(Burdwanriceyield$burdwan,Burdwanweather$Max.Temperature,
#'                        Burdwanweather$Min.Temperature)
#' i.wwi.maxmintem

i.wwi=function(y,weatherp1,weatherp2){
  t=1:length(y)
  week=1:(length(weatherp1)/length(t))
  wp1=data.frame(matrix(weatherp1,nrow=length(y),byrow=T))
  colnames(wp1)=1:length(week)
  wp2=data.frame(matrix(weatherp2,nrow=length(y),byrow=T))
  colnames(wp2)=1:length(week)
  xx=wp1*wp2
  detrended.y=(y-(lm(y~t)$fitted))
  cor(xx[,1:length(week)],detrended.y)
  rxx=cor(xx[,1:length(week)],detrended.y)
  rxxmat=matrix(rxx[,1])
  xxmat=as.matrix(xx)
  i.wwi=as.vector((t(rxxmat)%*%t(xxmat))/sum(rxx))
  return(i.wwi)
}



