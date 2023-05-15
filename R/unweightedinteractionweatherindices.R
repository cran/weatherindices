
#' Un-weighted Interaction Weather Indices
#' @description Converts the weekly interaction of two weather variable into yearly weighted interaction weather indices
#' @param y A vector of yearly yield data for t years
#' @param weatherp1 Weekly weather data for t years as vector of first weather variable(total observations= number of years*number of weeks in each year)
#' @param weatherp2 Weekly weather data for t years as vector of second weather variable(total observations= number of years*number of weeks in each year)
#'
#' @return A vector of interaction weather indices
#' @export
#' @references Jain, R. C., Agrawal, R., & Jha, M. P. (1980). Effect of climatic variables on rice yield and its forecast. MAUSAM, 31(4), 591-596.
#' @examples
#' data(Burdwanweather) #Weekly weather data for the rice growing season in Burdwan
#' data(Burdwanriceyield) #Yearly Yield data of rice  in Burdwan
#' i.uwwi.maxmintem<-i.uwwi(Burdwanriceyield$burdwan,Burdwanweather$Max.Temperature,
#'                          Burdwanweather$Min.Temperature)
#' i.uwwi.maxmintem

i.uwwi=function(y,weatherp1,weatherp2){
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
  i.uwwi=as.vector((t(rxxmat^0)%*%t(xxmat))/sum(rxx^0))
  return(i.uwwi)
}



