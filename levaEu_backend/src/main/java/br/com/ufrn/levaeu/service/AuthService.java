package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.repository.UserRepository;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

@Service
public class AuthService implements UserDetailsService {

    private final UserRepository userRepository;

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String emailOrPhone) throws UsernameNotFoundException {
        User user = userRepository.findByPhoneOrEmail(emailOrPhone, emailOrPhone);
        if(user == null){
            throw new UsernameNotFoundException("Usuário não encontrado!");
        }

        Collection<GrantedAuthority> authorities;
        if(user.getTypeUser().getName().equals("admin")){
            authorities = List.of(new SimpleGrantedAuthority("ROLE_ADMIN"), new SimpleGrantedAuthority("ROLE_DRIVER"), new SimpleGrantedAuthority("ROLE_DEFAULT"));
        } else if (user.getTypeUser().getName().equals("motorista")) {
            authorities = List.of(new SimpleGrantedAuthority("ROLE_DRIVER"), new SimpleGrantedAuthority("ROLE_DEFAULT"));
        } else {
            authorities = List.of(new SimpleGrantedAuthority("ROLE_DEFAULT"));
        }

        return new org.springframework.security.core.userdetails.User(emailOrPhone, user.getPass(), authorities);
    }
}
