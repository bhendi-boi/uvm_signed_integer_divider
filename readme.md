# UVM Signed Integer Divider

## File Structure

- `rtl` folder contains all the rtl modules in verilog
- `design.sv` contains the same modules in a sv file

### Resources

- Took this RTL from [opencores website](https://opencores.org/projects/signed_integer_divider)
- [github link](https://github.com/fabriziotappero/ip-cores/tree/arithmetic_core_signed_integer_divider)

### Design Spec

- Active Low reset
- Driver Signature

  ```
  reg	state_driver=0;
  always@(posedge clk)
  if(rst)begin
  	case(state_driver)
  		0:begin
  			start<=1;
  			state_driver<=1;
  			dividend<=$random;
  			divisor<=$random;
  		end
  		1:if(ready)begin
  			start<=0;
  			state_driver<=0;
  		end
  	endcase
  end
  ```

- Monitor Signature

  ```
  always@(posedge clk)
  if(rst)begin
  	case(state_m)
  		0:if(start)begin
  			if(dividend[31])$write("%6d	dividend=-%d",$time,(~dividend)+1);
  			else	$write("%6d	dividend=%d",$time,dividend);
  			if(divisor[31])$write("	divisor=-%d\n",(~divisor)+1);
  			else	$write("	divisor=%d\n",divisor);
  			state_m<=1;
  		end
  		1:if(ready)begin
  			state_m<=0;
  			if(quotient[31])$write("%6d	quotient=-%d",$time,(~quotient)+1);
  			else	$write("%6d	quotient=%d",$time,quotient);
  			if(remainder[31])$write("	remainder=-%d\n",(~remainder)+1);
  			else	$write("	remainder=%d\n",remainder);
  		end
  	endcase
  end

  ```
