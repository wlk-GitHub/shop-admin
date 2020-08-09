import com.fh.model.Member;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class TestLambda {

    @Test
    public  void test1(){
        List<String> names = new ArrayList<>();
        names.add("zhangsan1");
        names.add("zhangsan2");
        names.add("zhangsan3");
        names.add("zhangsan4");

        //循环遍历输出

    /*    for (String name : names) {
            System.out.println(name);
        }*/

        //lambda 循环遍历输出
        names.forEach(x -> System.out.println(x));

        names.forEach(System.out::println);

    }

        @Test
        public void test2(){
            List<Member>members = new ArrayList<>();
            Member member1 = new Member();
            member1.setMemberName("憨批");
            member1.setPassword("123456");
            Member member2 = new Member();
            member2.setMemberName("sad");
            member2.setPassword("5555");
            members.add(member1);
            members.add(member2);
       /*     for (Member member : members) {
                System.out.println(member.getMemberName()+":"+member.getPassword());
            }*/
            members.forEach(x -> System.out.println(x.getMemberName()+":"+x.getPassword()));



        }


}
