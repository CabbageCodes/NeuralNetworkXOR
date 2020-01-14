program main
  implicit none
  real, dimension(1:9) :: w
  real, dimension(3:5) :: o, delta
  real, dimension(1:4,1:3) :: t
  real, dimension(1:4) :: errors
  real :: alpha = 0.1, k=2.0
  integer :: iter = 0, i=0
  !Link threshold function
  interface
    real function f(k,net)
        real, intent(in) :: net, k
    end function
  end interface

  !x1, x2, and the target
  t(1,:) = (/ 0.0,0.0,0.0 /)
  t(2,:) = (/ 0.0,1.0,1.0 /)
  t(3,:) = (/ 1.0, 0.0, 1.0 /)
  t(4,:) = (/ 1.0, 1.0, 0.0 /)

  !Set random initial weight
  call random_number(w)
  open(10, FILE='errors.dat' STATUS='replace')

  do iter = 1, 10000 !How many times to train perceptron
    do i = 1,4 !Loop over all input possibilities 00 01 10 11
        !calculate all outputs
        o(3) = f(k, w(1)+w(4)*t(i,1)+w(6)*t(i,2))
        o(4) = f(k, w(2)+w(5)*t(i,1)+w(7)*t(i,2))
        o(5) = f(k, w(3)+w(8)*o(3)+w(9)*o(4))
        !calculate all the deltas using Beale and Jackson textbook derivation
        delta(5) = k*o(5)*(1.0-o(5))*(t(i,3)-o(5))
        delta(4) = k*o(4)*(1.0-o(4))*delta(5)*w(9)
        delta(3) = k*o(3)*(1.0-o(3))*delta(5)*w(8)
        ! now actually update the weights
        w(1) = w(1) + alpha * delta(3)
        w(2) = w(2) + alpha * delta(4)
        w(3) = w(3) + alpha * delta(5)
        w(4) = w(4) + alpha * delta(3) * t(i,1)
        w(5) = w(5) + alpha * delta(4) * t(i,1)
        w(6) = w(6) + alpha * delta(3) * t(i,2)
        w(7) = w(7) + alpha * delta(4) * t(i,2)
        w(8) = w(8) + alpha * delta(5) * o(3)
        w(9) = w(9) + alpha * delta(5) * o(4)
      ! calculate errors
      errors(i) = 0.5*(o(5)-t(i,3))**2
    end do
    write(6,"(a,5(f10.5,1x))") "errors: ",errors,sum(errors)
    write(10,"(5(f10.5,1x))") errors,sum(errors)
 end do
 ! write out truth table
  do i=1,4
    ! calculate all outputs
    o(3) = f(k,w(1)+w(4)*t(i,1)+w(6)*t(i,2))
    o(4) = f(k,w(2)+w(5)*t(i,1)+w(7)*t(i,2))
    o(5) = f(k,w(3)+w(8)*o(3)+w(9)*o(4))
    write(6,*) t(i,1), t(i,2), t(i,3), o(5), nint(o(5))
  end do
end program
real function f(k,net)
    implicit none
    real, intent(in) :: net, k

    f=1/(1+exp(-k*net))
end function
