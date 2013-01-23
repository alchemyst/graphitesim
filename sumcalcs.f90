!implicit none

subroutine opencross(M, O, msize, nsize)
  integer(1), dimension(msize,nsize), intent(in) :: M
  integer(1), dimension(msize,nsize), intent(out) :: O
  integer, intent(in) :: msize, nsize
  integer :: i, j

  forall (i = 2:msize-1, j=2:nsize-1)
     O(i, j) = M(i, j-1) + M(i, j+1) + M(i-1, j) + M(i+1, j)
  end forall
end subroutine opencross

subroutine circle(M, O, msize, nsize)
  integer(1), dimension(msize,nsize), intent(in) :: M
  integer(1), dimension(msize,nsize), intent(out) :: O
  integer, intent(in) :: msize, nsize
  integer :: i, j

  forall (i = 2:msize-1, j=2:nsize-1)
     O(i, j) = M(i-1, j-1) + M(i-1, j) + M(i-1, j+1) + &
               M(i, j-1) +               M(i, j+1) + &
               M(i+1, j-1) + M(i+1, j) + M(i+1, j+1)
  end forall
end subroutine circle
